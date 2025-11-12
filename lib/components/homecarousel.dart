import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  final double Function(double) scaleY;
  final ThemeData theme;

  const BannerCarousel({super.key, required this.scaleY, required this.theme});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Add your banner images here
  final List<String> bannerImages = [
    "assets/jawaker.png",
    "assets/pubgbanner.png",
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: widget.scaleY(200).clamp(160.0, 220.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // PageView for swipeable banners
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: bannerImages.length,
            itemBuilder: (context, index) {
              return Image.asset(
                bannerImages[index],
                width: screenWidth,
                fit: BoxFit.fill,
                alignment: Alignment.center,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
              );
            },
          ),
          // Page indicators
          Positioned(
            bottom: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                bannerImages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Usage in your HomeScreen:
// Replace _buildBanner(context, scaleY, theme) with:
// BannerCarousel(scaleY: scaleY, theme: theme)
