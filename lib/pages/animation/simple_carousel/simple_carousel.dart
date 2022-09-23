import 'dart:math';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

import 'carousel_card.dart';

class SimpleCarousel extends StatefulWidget {
  const SimpleCarousel({Key? key}) : super(key: key);

  static const routeName = '/simple_carousel';

  @override
  State<SimpleCarousel> createState() => _SimpleCarouselState();
}

class _SimpleCarouselState extends State<SimpleCarousel> {
  final cards = [
    const CarouselCard(icon: Icons.bolt_outlined, label: 'Power'),
    const CarouselCard(icon: Icons.edit_outlined, label: 'Edit'),
    const CarouselCard(icon: Icons.home_outlined, label: 'Home'),
  ];
  final carouselController = PageController(viewportFraction: 0.7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimpleCarousel'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 36),
          ExpandablePageView.builder(
            controller: carouselController,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            clipBehavior: Clip.none, // allows our shadow to be displayed outside of widget bounds
            itemCount: cards.length,
            itemBuilder: (_, index) {
              if (!carouselController.position.haveDimensions) {
                return const SizedBox();
              }
              return AnimatedBuilder(
                animation: carouselController,
                builder: (_, __) => Transform.scale(
                  // get 1 if current page or 0.8
                  scale: max(0.8, (1 - (carouselController.page! - index).abs() / 2)),
                  child: cards[index],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          SmoothPageIndicator(
            controller: carouselController,
            count: cards.length,
            effect: SwapEffect(
              dotColor: Colors.grey.shade300,
              activeDotColor: Colors.blue.shade300,
              dotHeight: 8,
              dotWidth: 32,
            ),
          ),
        ],
      ),
    );
  }
}
