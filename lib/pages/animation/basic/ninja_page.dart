import 'package:flutter/material.dart';

import 'models/ninja.dart';

class NinjaPage extends StatefulWidget {
  const NinjaPage({Key? key}) : super(key: key);

  static const routeName = '/ninja';
  @override
  _NinjaPageState createState() => _NinjaPageState();
}

class _NinjaPageState extends State<NinjaPage> {
  @override
  Widget build(BuildContext context) {
    final ninja = ModalRoute.of(context)!.settings.arguments as NinjaData;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(ninja.name),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 320,
            width: double.infinity,
            child: Hero(
              tag: 'ninja-${ninja.id}',
              child: Image.network(
                'https://images.pexels.com/photos/3566120/pexels-photo-3566120.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: Text(ninja.name),
            subtitle: Text('Age: ${ninja.age} - Power: ${ninja.power}'),
            trailing: const AnimatedFavButton(),
          )
        ],
      ),
    );
  }
}

class AnimatedFavButton extends StatefulWidget {
  const AnimatedFavButton({Key? key}) : super(key: key);

  @override
  _AnimatedFavButtonState createState() => _AnimatedFavButtonState();
}

class _AnimatedFavButtonState extends State<AnimatedFavButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _curve;

  bool _isFav = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _curve = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          setState(() => _isFav = true);
          break;
        case AnimationStatus.dismissed:
          setState(() => _isFav = false);
          break;
        default:
      }
    });

    _colorAnimation = ColorTween(begin: Colors.grey, end: Colors.red).animate(_curve);

    _sizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 30), weight: 50),
    ]).animate(_curve);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _isFav ? _controller.reverse() : _controller.forward();
      },
      icon: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Icon(
            Icons.favorite,
            color: _colorAnimation.value,
            size: _sizeAnimation.value,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
