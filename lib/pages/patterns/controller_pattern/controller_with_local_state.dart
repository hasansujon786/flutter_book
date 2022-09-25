import 'package:flutter/material.dart';

// typedef MyTypedef(int value);

class ControllerWithLocalState {
  VoidCallback increase = () {};
  // MyTypedef functionThatReturns;

  void dispose() {
    increase = () {};
    //Remove any data that's will cause a memory leak/render errors in here
    // myFunction = null;
    // mySecondFunction = null;
    // functionThatReturns = null;
  }
}

class ControllerWithLocalStateExample extends StatefulWidget {
  const ControllerWithLocalStateExample({
    Key? key,
    this.controller,
  }) : super(key: key);

  final ControllerWithLocalState? controller;

  @override
  State<ControllerWithLocalStateExample> createState() => _ControllerWithLocalStateExampleState();
}

class _ControllerWithLocalStateExampleState extends State<ControllerWithLocalStateExample> {
  @override
  void initState() {
    super.initState();
    final controller = widget.controller;
    if (controller != null) {
      controller.increase = increase;
    }
  }

  var count = 0;
  void increase() {
    setState(() {
      count = count + 1;
      print('local count $count');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('$count');
  }
}
