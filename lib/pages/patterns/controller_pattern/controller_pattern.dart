import 'package:flutter/material.dart';

import 'controller_with_change_notifier.dart';
import 'controller_with_local_state.dart';

class ControllerPattern extends StatefulWidget {
  const ControllerPattern({Key? key}) : super(key: key);

  static const routeName = '/controller_pattern';

  @override
  State<ControllerPattern> createState() => _ControllerPatternState();
}

class _ControllerPatternState extends State<ControllerPattern> {
  late ControllerWithChangeNotifier controllerWithCn;
  late ControllerWithLocalState controllerWithLs;

  @override
  void initState() {
    super.initState();
    controllerWithCn = ControllerWithChangeNotifier();
    controllerWithLs = ControllerWithLocalState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ControllerExample'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            ControllerWithChangeNotifierExample(controller: controllerWithCn),
            ElevatedButton(
              onPressed: controllerWithCn.increase,
              child: const Text('increase'),
            ),
            const SizedBox(height: 30),
            ControllerWithLocalStateExample(controller: controllerWithLs),
            ElevatedButton(
              onPressed: () {
                controllerWithLs.increase();
              },
              child: const Text('increase'),
            )
          ],
        ),
      ),
    );
  }
}
