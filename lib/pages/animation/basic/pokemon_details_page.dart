import 'package:flutter/material.dart';

import '../../../config/config.dart';
import 'models/pokemon.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/pokemon_details';
  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)!.settings.arguments as PokemonData;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(pokemon.name),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 320,
            width: double.infinity,
            child: Hero(
              tag: 'ninja-${pokemon.id}',
              child: Image.asset(
                LocalAssets.backgroundNeonRed,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: Text(pokemon.name),
            subtitle: Text('Age: ${pokemon.age} - Power: ${pokemon.power}'),
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
  State<AnimatedFavButton> createState() => _AnimatedFavButtonState();
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
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 2), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 2, end: 1), weight: 50),
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
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.diagonal3Values(_sizeAnimation.value, _sizeAnimation.value, 0),
            child: Icon(
              Icons.favorite,
              color: _colorAnimation.value,
              size: 30,
            ),
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
