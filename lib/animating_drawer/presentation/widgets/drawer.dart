import 'package:flutter/material.dart';
import 'package:flutter_book/animating_drawer/presentation/screens/animating_drawer_screen.dart';

class AnimatingScaleDrawer extends StatefulWidget {
  const AnimatingScaleDrawer({super.key, this.child});

  final Widget? child;

  @override
  State<AnimatingScaleDrawer> createState() => _AnimatingScaleDrawerState();
}

class _AnimatingScaleDrawerState extends State<AnimatingScaleDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _dragThreshold = 30.0;
  final maxSlide = 200.0;

  double _currentDragX = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _onDragStart(DragStartDetails details) {
    _currentDragX = details.globalPosition.dx;
    _isDragging = _controller.isCompleted
        ? true
        : _currentDragX <= _dragThreshold;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;
    // dx = prevDragX - _currentDragX
    final dx = details.globalPosition.dx - _currentDragX;
    final newValue = (_controller.value + (dx / maxSlide)).clamp(0.0, 1.0);
    _controller.value = newValue;
    _currentDragX = details.globalPosition.dx;
  }

  void _onDragEnd(DragEndDetails details) {
    if (!_isDragging) return;
    _isDragging = false;
    final velocity = details.velocity.pixelsPerSecond.dx;
    if (velocity.abs() > 300) {
      velocity > 0 ? _controller.forward() : _controller.reverse();
    } else {
      _controller.value > 0.5 ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.grey.shade300,
                child: Text("this is drawer content"),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double slide = maxSlide * _controller.value;
                double scale = 1 - (_controller.value * 0.3);

                return Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..scale(scale)
                    ..translate(slide, 0.0),
                  child: child,
                );
              },
              child: AnimatingDrawerScreen(
                title: 'Flutter Demo Home Page',
                onToggle: () {
                  _controller.isCompleted
                      ? _controller.reverse()
                      : _controller.forward();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
