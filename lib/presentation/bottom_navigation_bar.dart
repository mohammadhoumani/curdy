import 'package:curdy/presentation/home_screen.dart';
import 'package:curdy/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

class UserTabBar extends StatefulWidget {
  const UserTabBar({super.key});

  @override
  State<UserTabBar> createState() => _UserTabBarState();
}

class _UserTabBarState extends State<UserTabBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    const Center(child: Text("Search Screen")),
    const Center(child: Text("Cart Screen")),
    Center(
      child: Builder(
        builder: (innerContext) {
          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                innerContext,
                MaterialPageRoute(builder: (context) => SplashScreen()),
              );
            },
            child: const Text("Logout "),
          );
        },
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildIconWidget(String assetPath, int index, ColorScheme colors) {
    final isSelected = _selectedIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color:
            isSelected ? colors.primary.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        assetPath,
        width: isSelected ? 28 : 26,
        height: isSelected ? 28 : 26,
        color: isSelected ? colors.primary : colors.onSurface.withOpacity(0.6),
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Scaffold(
      body:
          _selectedIndex < _screens.length
              ? _screens[_selectedIndex]
              : const Center(child: Text("Invalid screen index")),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colors.onSurface.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: colors.surface,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: colors.primary,
            unselectedItemColor: colors.onSurface.withOpacity(0.6),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
            items: [
              BottomNavigationBarItem(
                icon: _buildIconWidget('assets/icons/home.png', 0, colors),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildIconWidget('assets/icons/orders.png', 1, colors),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: _buildIconWidget('assets/icons/payment.png', 2, colors),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: _buildIconWidget('assets/icons/menu.png', 3, colors),
                label: 'Menu',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
