import 'dart:math';

import 'package:flutter/material.dart';

class SlidableCards extends StatefulWidget {
  const SlidableCards({Key? key}) : super(key: key);

  static const routeName = '/slidable_cards';
  @override
  State<SlidableCards> createState() => _SlidableCardsState();
}

class _SlidableCardsState extends State<SlidableCards> {
  final _itemCount = 5;
  var _page = 0.0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _itemCount);

    pageController.addListener(() {
      setState(() {
        _page = pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    pageController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          height: width,
          width: width,
          child: LayoutBuilder(
            builder: (context, boxConstraints) {
              const topCardVerPadding = 20.0;
              const otherCardsVerPadding = 30.0;
              const slideRatio = 0.75;
              List<Widget> cards = [];

              for (int i = 0; i < _itemCount; i++) {
                final currentPageValue = i - _page;
                final pageLocationDistance = currentPageValue > 0 ? 9 : 1;
                final leftPad = boxConstraints.maxWidth - width * slideRatio;
                double start = 10 + max(leftPad - (leftPad / 2) * -currentPageValue * pageLocationDistance, 0.0);

                var customizableCard = Positioned.directional(
                  top: topCardVerPadding + otherCardsVerPadding * max(-currentPageValue, 0.0),
                  bottom: topCardVerPadding + otherCardsVerPadding * max(-currentPageValue, 0.0),
                  start: start,
                  textDirection: TextDirection.ltr,
                  child: buildCard(width, i),
                );
                cards.add(customizableCard);
              }
              return Stack(children: cards);
            },
          ),
        ),
        Positioned.fill(
          child: PageView.builder(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: _itemCount,
            controller: pageController,
            itemBuilder: (context, index) {
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Container buildCard(double width, int pageIndex) {
    return Container(
      width: width * .67,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 10)],
      ),
      child: Text(pageIndex.toString()),
    );
  }
}
