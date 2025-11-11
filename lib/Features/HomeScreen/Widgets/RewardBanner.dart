import 'package:flutter/material.dart';

class RewardBannerCarousel extends StatefulWidget {
  final List<String> bannerImageUrls; // List of banner images from backend

  const RewardBannerCarousel({Key? key, required this.bannerImageUrls})
    : super(key: key);

  @override
  _RewardBannerCarouselState createState() => _RewardBannerCarouselState();
}

class _RewardBannerCarouselState extends State<RewardBannerCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % widget.bannerImageUrls.length;

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        setState(() {
          _currentPage = nextPage;
        });

        _startAutoSlide();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.bannerImageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    // Add navigation or action here
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(widget.bannerImageUrls[index]),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // Dots Indicator
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.bannerImageUrls.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 12 : 8,
                  height: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white54,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
