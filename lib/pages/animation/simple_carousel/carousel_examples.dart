import 'package:flutter/material.dart';

import 'slidable_cards.dart';
import 'simple_carousel.dart';

class CarouselExamples extends StatefulWidget {
  const CarouselExamples({Key? key}) : super(key: key);

  static const routeName = '/carousel_examples';

  @override
  State<CarouselExamples> createState() => _CarouselExamplesState();
}

class _CarouselExamplesState extends State<CarouselExamples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimpleCarousel'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SlidableCards(),
            SimpleCarousel(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
