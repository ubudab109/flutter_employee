import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselHighlight extends StatelessWidget {
  const CarouselHighlight(
      {Key? key,
      required this.images,
      required this.size,
      this.onPageChanged,
      required this.activeIndexImages, 
      required this.onDotClicked, required this.controller})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  // LIST IMAGES IN CAROUSEL
  final List<dynamic> images;

  // SIZE FOR RESPONSIVE
  final Size size;

  // ON PAGE CHANGED FOR INDICATOR CAROUSEL
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  // CURRENT CAROUSEL INDEX
  final int activeIndexImages;

  // CONTROLLER FOR DOT
  final Function(int index) onDotClicked;
  
  final CarouselController controller;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: images.length,
            carouselController: controller,
            options: CarouselOptions(
                initialPage: activeIndexImages,
                // height: size.height * .25,
                autoPlay: false,
                aspectRatio: 2,
                autoPlayInterval: const Duration(seconds: 2),
                enlargeCenterPage: false,
                onPageChanged: onPageChanged),
            itemBuilder: (context, index, realIndex) {
              final urlImage = images[index];

              return buildImages(urlImage, index);
            },
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          buildIndicator(),
          SizedBox(
              height: size.height * 0.05,
            ),
        ],
      ),
    );
  }

  Widget buildImages(urlImage, int index) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () => {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              urlImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndexImages, 
      count: images.length,
      onDotClicked: onDotClicked,
      effect: const SlideEffect(
        dotWidth: 13,
        dotHeight: 13,
        activeDotColor: Color(0XFF4AD3FE),
        dotColor: Color(0XFFDADADA)
      ),
    );
}
