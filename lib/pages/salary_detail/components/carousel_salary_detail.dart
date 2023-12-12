import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSalarDetail extends StatelessWidget {
  const CarouselSalarDetail(
      {Key? key,
      required this.size,
      this.onPageChanged,
      required this.activeIndex,
      required this.onDotClicked,
      required this.controller, this.itemBuilder,})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables

  // SIZE FOR RESPONSIVE
  final Size size;

  // ON PAGE CHANGED FOR INDICATOR CAROUSEL
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  // CURRENT CAROUSEL INDEX
  final int activeIndex;

  // CONTROLLER FOR DOT
  final Function(int index) onDotClicked;
  final ExtendedIndexedWidgetBuilder? itemBuilder;
  
  final CarouselController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          child: CarouselSlider.builder(
            itemCount: 2,
            options: CarouselOptions(
              pageSnapping: true,
                initialPage: activeIndex,
                autoPlay: false,
                aspectRatio: 2,
                autoPlayInterval: const Duration(seconds: 2),
                enlargeCenterPage: true,
                viewportFraction: 1,
                onPageChanged: onPageChanged),
            carouselController: controller,
            itemBuilder: itemBuilder,
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        buildIndicator(),
        // SizedBox(
        //     height: size.height * 0.05,
        //   ),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex, 
      count: 2,
      onDotClicked: onDotClicked,
      effect: const SlideEffect(
        dotWidth: 13,
        dotHeight: 13,
        activeDotColor: Color(0XFF4AD3FE),
        dotColor: Color(0XFFDADADA)
      ),
    );
}
