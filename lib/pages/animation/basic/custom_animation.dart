import 'package:flutter/material.dart';

import 'samples/anim_widget_vs_builder.dart';

class CustomAnimation extends StatelessWidget {
  const CustomAnimation({super.key});

  static const routeName = '/custom_anmation';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Animation'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20, width: width),
          const AnimWidgetVsBuilder(),
        ],
      ),
    );
  }
}
