import 'package:curdy/presentation/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:curdy/presentation/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Wait for 2 seconds to show splash screen
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    // Demo: Change this to true to simulate logged in, false for not logged in
    final bool isLoggedIn = false; // Change to true to test logged in flow

    // Navigate based on login status
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder:
            (context) =>
                isLoggedIn
                    ? const UserTabBar() // Your main app screen
                    : const WelcomeScreen(), // Your login screen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size screenSize = MediaQuery.of(context).size;
    const double designWidth = 375;
    const double designHeight = 812;

    double scaleX(double value) => value * screenSize.width / designWidth;
    double scaleY(double value) => value * screenSize.height / designHeight;

    final double footerFontSize = math.max(10.0, math.min(18.0, scaleY(15)));
    final double footerLogoHeight = math.max(16.0, math.min(28.0, scaleY(22)));

    final Color primaryBlue = theme.colorScheme.primary;
    final Color secondaryBlue = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-left organic blue blob
          Positioned(
            top: scaleY(116.34),
            left: scaleX(-220.03),
            child: Transform.rotate(
              angle: 22.35 * math.pi / 180,
              child: Container(
                width: scaleX(289.25758005027683),
                height: scaleY(327.3752878897055),
                decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(60.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(90, 0, 0, 0).withOpacity(0.6),
                      blurRadius: 40,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Top-right rounded shape
          Positioned(
            top: scaleY(-116.34),
            right: scaleX(-240.03),
            child: Transform.rotate(
              angle: 22.35 * math.pi / 180,
              child: Container(
                width: scaleX(289.25758005027683),
                height: scaleY(327.3752878897055),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        3,
                        53,
                        53,
                        53,
                      ).withOpacity(0.6),
                      blurRadius: 30,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  color: secondaryBlue,
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
            ),
          ),
          // Bottom soft wave-ish background
          Positioned(
            top: scaleY(590),
            left: scaleX(-40.61),
            child: Opacity(
              opacity: 0.2,
              child: CustomPaint(
                size: Size(
                  scaleX(497.1677551269531),
                  scaleY(338.5238342285156),
                ),
                painter: _BottomWavePainter(
                  primary: primaryBlue,
                  secondary: secondaryBlue,
                ),
              ),
            ),
          ),
          // Upper subtle wave overlay above the bottom vector
          Positioned(
            bottom: 0,
            left: scaleX(-24.66),
            child: Opacity(
              opacity: 0.15,
              child: CustomPaint(
                size: Size(
                  scaleX(500.3841857910156),
                  scaleY(383.58941650390625),
                ),
                painter: UpperVector(
                  primary: primaryBlue,
                  secondary: secondaryBlue,
                ),
              ),
            ),
          ),
          // Center content: logo and title
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App logo
                SizedBox(
                  height: scaleY(250),
                  width: scaleX(250),
                  child: const Image(
                    image: AssetImage('assets/splash_logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: scaleY(12)),

                // App name (we keep gap for potential future text)
              ],
            ),
          ),
          // Footer: Powered by + Brainkets logo
          Positioned(
            bottom: scaleY(85),
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Powered By',
                    style: TextStyle(
                      fontSize: footerFontSize,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: scaleX(8)),
                  SizedBox(
                    height: footerLogoHeight,
                    child: Image.asset(
                      'assets/brainkets_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomWavePainter extends CustomPainter {
  const _BottomWavePainter({required this.primary, required this.secondary});

  final Color primary;
  final Color secondary;

  @override
  void paint(Canvas canvas, Size size) {
    // Solid fill (secondary color only)
    final Paint fillPaint = Paint()..color = secondary;

    // Top wave path
    final Path wavePath =
        Path()
          ..moveTo(0, size.height * 0.15)
          ..cubicTo(
            size.width * 0.10,
            0, // control 1
            size.width * 0.35,
            size.height * 0.05, // control 2
            size.width * 0.52,
            size.height * 0.35, // end
          )
          ..cubicTo(
            size.width * 0.67,
            size.height * 0.60,
            size.width * 0.88,
            size.height * 0.68,
            size.width,
            size.height * 0.62,
          )
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();

    canvas.drawPath(wavePath, fillPaint);

    // Single color: no inner highlight layer

    // No border stroke as requested
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class UpperVector extends CustomPainter {
  const UpperVector({required this.primary, required this.secondary});

  final Color primary;
  final Color secondary;

  @override
  void paint(Canvas canvas, Size size) {
    // Solid fill (single color)
    final Paint fillPaint = Paint()..color = secondary;

    // Smooth wave path matching the image
    final Path wavePath =
        Path()
          // Start point: left edge at 50% height (middle of left side)
          ..moveTo(0, size.height * 0.5)
          // First cubic Bezier curve - creates the left dip
          ..cubicTo(
            size.width * 0.1, // Control point 1 X: 10% from left
            size.height *
                0.8, // Control point 1 Y: 80% from top (pulls curve DOWN)
            size.width * 0.3, // Control point 2 X: 30% from left
            size.height * 0.6, // Control point 2 Y: 50% from top (middle)
            size.width * 0.4, // End point X: 50% from left (center)
            size.height * 0.50, // End point Y: 40% from top (slight rise)
          )
          // Second cubic Bezier curve - smooth continuation to the right
          ..cubicTo(
            size.width *
                0.65, // Control point 1 X: 65% from left (moves RIGHT, not back left)
            size.height *
                0.3, // Control point 1 Y: 35% from top (continues the upward trend)
            size.width *
                0.8, // Control point 2 X: 85% from left (near right edge)
            size.height * 0.6, // Control point 2 Y: 50% from top (gentle curve)
            size.width, // End point X: right edge (100%)
            size.height * 0.6, // End point Y: 60% from top (ends lower-middle)
          )
          // Draw straight line to bottom-right corner
          ..lineTo(size.width, size.height)
          // Draw straight line to bottom-left corner
          ..lineTo(0, size.height)
          // Close the path (connects back to starting point)
          ..close();
    // Base wave fill
    canvas.drawPath(wavePath, fillPaint);

    // Single color: no highlight overlay
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
