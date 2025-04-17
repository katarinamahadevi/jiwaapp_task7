import 'package:flutter/material.dart';


class HomeBanner extends StatefulWidget {
  final double height;

  const HomeBanner({Key? key, required this.height}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<String> _bannerImages = [
    'assets/banner/banner1.jpg',
    'assets/banner/banner2.jpg',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: widget.height,
        decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _bannerImages.length,
              itemBuilder: (context, index) {
                return Image.asset(_bannerImages[index], fit: BoxFit.cover);
              },
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < _bannerImages.length; i++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentPage == i
                    ? const Color(0xFFFD514F) 
                    : Colors.white.withOpacity(0.5), 
          ),
        ),
      );
    }

    return indicators;
  }
}
