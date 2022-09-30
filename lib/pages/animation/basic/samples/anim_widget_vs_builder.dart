import 'package:flutter/material.dart';

class AnimWidgetVsBuilder extends StatefulWidget {
  const AnimWidgetVsBuilder({super.key});

  @override
  State<AnimWidgetVsBuilder> createState() => _AnimWidgetVsBuilderState();
}

class _AnimWidgetVsBuilderState extends State<AnimWidgetVsBuilder> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _sizeAnim;
  late Animation<double> _opacityAnim;
  late Animation<Offset> _offsetAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    final curveAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
      // curve: const Interval(0, 1, curve: Curves.easeOut),
    );

    _sizeAnim = Tween<double>(begin: .3, end: 1).animate(curveAnim);
    _opacityAnim = Tween<double>(begin: 0, end: 1).animate(curveAnim);
    _offsetAnim = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, .3)).animate(curveAnim);

    // _controller.forward();
    // _controller.repeat(reverse: true);
  }

  void runAnimation() {
    // _controller.forward(from: 0);
    _controller.repeat(reverse: true);
  }

  var foo = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(onPressed: runAnimation, child: const Text('Play')),
        withAnimatedBuilder(),
        const SizedBox(height: 40),
        withTransitions(),
        const SizedBox(height: 40),
        MyAnimatedWidget(animation: _controller, child: squire()),
      ],
    );
  }

  SlideTransition withTransitions() {
    return SlideTransition(
      position: _offsetAnim,
      child: squire2(
        child: ScaleTransition(
          scale: _sizeAnim,
          child: FadeTransition(
            opacity: _opacityAnim,
            child: squire(),
          ),
        ),
      ),
    );
  }

  Widget withAnimatedBuilder() {
    return AnimatedBuilder(
      animation: _controller,
      child: squire2(
        child: AnimatedBuilder(
          animation: _controller,
          child: squire(),
          builder: (context, child) => Opacity(
            opacity: _opacityAnim.value,
            child: Transform.scale(
              scale: _sizeAnim.value,
              child: child,
            ),
          ),
        ),
      ),
      builder: (context, child) => FractionalTranslation(
        translation: _offsetAnim.value,
        child: child,
      ),
    );
  }

  Container squire() {
    foo = foo + 1;
    print(foo);
    return Container(height: 100, width: 100, color: Colors.red.shade300);
  }

  Container squire2({Widget? child}) {
    foo = foo + 1;
    print(foo);
    return Container(color: Colors.cyan.shade100, child: child);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MyAnimatedWidget extends AnimatedWidget {
  const MyAnimatedWidget({
    super.key,
    required Animation<double> animation,
    required this.child,
  }) : super(listenable: animation);

  final Widget child;

  Animation<double> get anim => listenable as Animation<double>;

  CurvedAnimation get curve => CurvedAnimation(parent: anim, curve: Curves.fastOutSlowIn);

  Animation<double> get sizeAnim => Tween<double>(begin: .3, end: 1).animate(curve);
  Animation<Offset> get offsetAnim => Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, .3)).animate(curve);

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: offsetAnim.value,
      child: Container(
        color: Colors.cyan.shade100,
        child: Opacity(
          opacity: anim.value,
          child: Transform.scale(
            scale: sizeAnim.value,
            child: child,
          ),
        ),
      ),
    );
  }
}
