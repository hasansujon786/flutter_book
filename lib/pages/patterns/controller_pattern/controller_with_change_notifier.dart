import 'package:flutter/material.dart';

class ControllerWithChangeNotifier extends ChangeNotifier {
  var count = 0;

  void increase() {
    count = count + 1;
    print('count $count');
    notifyListeners();
  }
}

class ControllerWithChangeNotifierExample extends StatefulWidget {
  const ControllerWithChangeNotifierExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ControllerWithChangeNotifier controller;

  @override
  State<ControllerWithChangeNotifierExample> createState() => _ControllerWithChangeNotifierExampleState();
}

class _ControllerWithChangeNotifierExampleState extends State<ControllerWithChangeNotifierExample> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('${widget.controller.count}');
  }
}
