import 'package:flutter/material.dart';

const _appbarHeight = 250.00;
const _avaterSize = 100.00;

class StaggeredProfilePageAnimator extends StatefulWidget {
  const StaggeredProfilePageAnimator({Key? key}) : super(key: key);

  static const routeName = '/staggered_profile';
  @override
  State<StaggeredProfilePageAnimator> createState() => _StaggeredProfilePageAnimatorState();
}

class _StaggeredProfilePageAnimatorState extends State<StaggeredProfilePageAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredProfilePage(_controller);
  }
}

class StaggeredProfilePage extends StatelessWidget {
  final AnimationController controller;
  final ProfilePageEnterAnimation animation;
  StaggeredProfilePage(this.controller, {Key? key})
      : animation = ProfilePageEnterAnimation(controller),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedBuilder(
        animation: animation.controller,
        builder: (BuildContext context, Widget? child) {
          return buildAnimatedBody(context, child, screenWidth);
        },
      ),
    );
  }

  Column buildAnimatedBody(BuildContext context, Widget? child, double screenWidth) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              appBar(animation.appbarHeight.value),
              avater(_avaterSize, screenWidth, animation.avaterSize.value),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Opacity(opacity: animation.titleOpaciry.value, child: skeleton(30, 180, Alignment.topLeft)),
              Opacity(
                  opacity: animation.contentOpaciry.value, child: skeleton(250, double.infinity, Alignment.topLeft)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget appBar(double height) {
    return Container(
      height: height,
      width: double.infinity,
      color: Colors.blue,
    );
  }

  Widget avater(double size, double screenWidth, double animatedValue) {
    return Positioned(
      top: _appbarHeight - (size / 2),
      left: screenWidth / 2 - (size / 2),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(animatedValue, animatedValue, animatedValue),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget skeleton(double height, double width, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}

class ProfilePageEnterAnimation {
  final AnimationController controller;
  ProfilePageEnterAnimation(this.controller)
      : appbarHeight = Tween<double>(begin: 0, end: _appbarHeight).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.3, curve: Curves.easeIn),
          ),
        ),
        avaterSize = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.3, 0.6, curve: Curves.elasticOut),
          ),
        ),
        titleOpaciry = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 0.65, curve: Curves.easeIn),
          ),
        ),
        contentOpaciry = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.65, 0.8, curve: Curves.easeIn),
          ),
        );

  final Animation<double> appbarHeight;
  final Animation<double> avaterSize;
  final Animation<double> titleOpaciry;
  final Animation<double> contentOpaciry;
}
