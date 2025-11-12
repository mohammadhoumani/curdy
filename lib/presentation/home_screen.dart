import 'package:curdy/components/balance_bottom_sheet.dart';
import 'package:curdy/components/categorysection.dart';
import 'package:curdy/components/homecarousel.dart';
import 'package:curdy/model/service_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    const double designWidth = 375;
    const double designHeight = 812;

    double scaleX(double value) => value * size.width / designWidth;
    double scaleY(double value) => value * size.height / designHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextButton(
          onPressed: () => showAccountBalanceSheet(context),
          child: Text(
            '1000 USD',
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: scaleY(18).clamp(16.0, 20.0),
            ),
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(scaleX(12)),
          child: Image.asset(
            'assets/icons/crudy.png',
            width: scaleX(32),
            height: scaleY(32),
            errorBuilder:
                (context, error, stackTrace) => Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              size: scaleY(26).clamp(24.0, 28.0),
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.person_outline,
              size: scaleY(26).clamp(24.0, 28.0),
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: scaleX(16),
              vertical: scaleY(12),
            ),
            child: Container(
              height: scaleY(44).clamp(40.0, 48.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: scaleY(14).clamp(13.0, 15.0),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                    size: scaleY(22).clamp(20.0, 24.0),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: scaleX(16),
                    vertical: scaleY(12),
                  ),
                ),
              ),
            ),
          ),
          // Main Content - Scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner Section - Full Width
                  BannerCarousel(scaleY: scaleY, theme: theme),
                  SizedBox(height: scaleY(20)),
                  // Telecom Section
                  buildCategorySection(
                    context: context,
                    title: 'Telecom',
                    items: [
                      ServiceItem(
                        name: 'TOUCH',
                        asset: 'assets/icons/touch.png',
                      ),
                      ServiceItem(name: 'ALFA', asset: 'assets/icons/alfa.png'),
                      ServiceItem(
                        name: 'Ogero',
                        asset: 'assets/icons/ogero.png',
                      ),
                      ServiceItem(
                        name: 'E-Sim',
                        asset: 'assets/icons/e-sim.png',
                      ),
                    ],
                    scaleX: scaleX,
                    scaleY: scaleY,
                    theme: theme,
                  ),
                  SizedBox(height: scaleY(24)),
                  // Streaming Section
                  buildCategorySection(
                    context: context,
                    title: 'Streaming',
                    items: [
                      ServiceItem(
                        name: 'Netflix',
                        asset: 'assets/icons/netflix.png',
                      ),
                      ServiceItem(
                        name: 'Shahid',
                        asset: 'assets/icons/shahid.png',
                      ),
                      ServiceItem(name: 'IPTV', asset: 'assets/icons/iptv.png'),
                      ServiceItem(
                        name: 'Disney+',
                        asset: 'assets/icons/disney.png',
                      ),
                      ServiceItem(
                        name: 'Anghami',
                        asset: 'assets/icons/anghami.png',
                      ),
                    ],
                    scaleX: scaleX,
                    scaleY: scaleY,
                    theme: theme,
                  ),
                  SizedBox(height: scaleY(24)),
                  // Gaming Section
                  buildCategorySection(
                    context: context,
                    title: 'Social & Live Applications',
                    items: [
                      ServiceItem(
                        name: 'Bigo Live',
                        asset: 'assets/icons/bigolive.png',
                      ),
                      ServiceItem(
                        name: 'Like Live',
                        asset: 'assets/icons/likelive.png',
                      ),
                      ServiceItem(
                        name: 'Tiktok',
                        asset: 'assets/icons/tiktok.png',
                      ),
                      ServiceItem(name: 'Yoho', asset: 'assets/icons/yoho.png'),
                    ],
                    scaleX: scaleX,
                    scaleY: scaleY,
                    theme: theme,
                  ),
                  SizedBox(
                    height: scaleY(100),
                  ), // Bottom padding for navigation
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
