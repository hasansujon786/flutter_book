// 2022-09-23
// https://docs.flutter.dev/cookbook/effects/parallax-scrolling
// https://www.youtube.com/watch?v=ZPdG0mCtTYg&t=1337s

import 'package:flutter/material.dart';

import './widgets/custom_app_bar.dart';
import './widgets/list_item.dart';

const _primary = Color(0xff000B40);
const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class ParallaxList extends StatelessWidget {
  const ParallaxList({Key? key}) : super(key: key);

  static const routeName = '/parallax_list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primary,
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        elevation: 0,
        flexibleSpace: const CustomAppBar(),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 110),
          child: Column(
            children: [
              for (final location in locations)
                LocationListItem(
                  imageUrl: location.imageUrl,
                  name: location.name,
                  country: location.place,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
