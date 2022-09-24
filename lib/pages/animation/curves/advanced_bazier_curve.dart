// https://medium.com/thebrand/bezier-animations-ui-elements-to-flutter-widgets-part-1-95c04b6ba1c4
import 'package:flutter/material.dart';

class AdvancedBazierCurve extends StatefulWidget {
  const AdvancedBazierCurve({Key? key}) : super(key: key);

  static const routeName = '/advanced_bazier_curve';
  @override
  State<AdvancedBazierCurve> createState() => _AdvancedBazierCurveState();
}

class _AdvancedBazierCurveState extends State<AdvancedBazierCurve> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('hello'),
      ),
    );
  }
}
