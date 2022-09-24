// https://www.youtube.com/watch?v=P0eZ0XH5FdI&list=TLPQMjMwOTIwMjKf6dvcP8FEyg&index=5
// ==> tools
// https://itchylabs.com/tools/path-to-bezier/
// https://fluttershapemaker.com/
import 'package:flutter/material.dart';
import 'package:flutter_book/pages/animation/curves/clip_shadow_path.dart';

class BasicClipPathExample extends StatelessWidget {
  const BasicClipPathExample({Key? key}) : super(key: key);

  static const routeName = '/basic_clip_path';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade700,
      appBar: AppBar(
        title: const Text('CurveBasice'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              ClipShadowPath(
                shadow: const BoxShadow(
                  color: Colors.black38,
                  offset: Offset(4, 4),
                  blurRadius: 4,
                  spreadRadius: 8,
                ),
                clipper: BigCurveCliper(),
                child: Container(height: 240, color: Colors.orangeAccent),
              ),
              ClipShadowPath(
                shadow: const BoxShadow(
                  color: Colors.black38,
                  offset: Offset(4, 4),
                  blurRadius: 4,
                  spreadRadius: 8,
                ),
                clipper: BigCurveCliper(),
                child: Container(height: 200, color: Colors.orangeAccent.shade700),
              ),
              ClipShadowPath(
                shadow: const BoxShadow(
                  color: Colors.black38,
                  offset: Offset(4, 4),
                  blurRadius: 4,
                  spreadRadius: 8,
                ),
                clipper: MyArcClipper(),
                child: Container(
                  height: 150,
                  color: Colors.orangeAccent,
                  child: const Center(
                    child: Text('Hello World'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 100,
              width: 100,
              color: Colors.orangeAccent,
            ),
          )
        ],
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    // // rectangle
    // final path = Path()
    //   ..lineTo(0, h)
    //   ..lineTo(w, h)
    //   ..lineTo(w, 0)
    //   ..close();

    // // triangle
    // final path = Path()
    //   ..moveTo(w / 2, 0)
    //   ..lineTo(0, h)
    //   ..lineTo(w, h);
    // ..close();

    // // trapijiam
    // final path = Path()
    //   ..moveTo(w * .2, 0)
    //   ..lineTo(w * .8, 0)
    //   ..lineTo(w, h)
    //   ..lineTo(0, h)
    //   ..close();

    // Star
    final path = Path()
      ..moveTo(w * .5, 0)
      ..lineTo(w * .61, h * .35)
      ..lineTo(w * .98, h * .35)
      ..lineTo(w * .68, h * .57)
      ..lineTo(w * .79, h * .91)
      ..lineTo(w * .5, h * .7)
      ..lineTo(w * .21, h * .91)
      ..lineTo(w * .32, h * .57)
      ..lineTo(w * .02, h * .35)
      ..lineTo(w * .39, h * .35)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class MyArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    // Arc
    final path = Path()
      ..lineTo(0, h - 50)
      ..quadraticBezierTo(w * .5, h, w, h - 50)
      ..lineTo(w, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BigCurveCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 200;
    final double yScaling = size.height / 120;
    path.lineTo(0 * xScaling, 0 * yScaling);
    path.cubicTo(
      0 * xScaling,
      0 * yScaling,
      200 * xScaling,
      0 * yScaling,
      200 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      200 * xScaling,
      0 * yScaling,
      200 * xScaling,
      120.513 * yScaling,
      200 * xScaling,
      120.513 * yScaling,
    );
    path.cubicTo(
      200 * xScaling,
      120.513 * yScaling,
      165.793 * xScaling,
      118.955 * yScaling,
      135.238 * xScaling,
      113.777 * yScaling,
    );
    path.cubicTo(
      106.85 * xScaling,
      108.96600000000001 * yScaling,
      80.213 * xScaling,
      99.787 * yScaling,
      55.962999999999994 * xScaling,
      99.787 * yScaling,
    );
    path.cubicTo(
      5.962999999999994 * xScaling,
      99.787 * yScaling,
      -0.0010000000000047748 * xScaling,
      111.18700000000001 * yScaling,
      -0.0010000000000047748 * xScaling,
      111.18700000000001 * yScaling,
    );
    path.cubicTo(
      -0.0010000000000047748 * xScaling,
      111.18700000000001 * yScaling,
      0 * xScaling,
      0 * yScaling,
      0 * xScaling,
      0 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
