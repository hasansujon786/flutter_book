import 'package:flutter/material.dart';
import 'package:flutter_book/core/route_names.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        foregroundDecoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
        ),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            TextButton(
              onPressed: () {
                context.push(Routes.animatingDrawer);
              },
              child: Text("Animating Drawer"),
            ),
            Text('asdf'),
            Text('asdf'),
            Text('asdf'),
            Text('asdf'),
            Text('asdf'),
            Text('asdf'),
            Text('asdf'),
          ],
        ),
      ),
    );
  }
}
