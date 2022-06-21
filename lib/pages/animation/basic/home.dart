import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../pages.dart';
import 'models/pokemon.dart';

class BasicAnimationHome extends StatefulWidget {
  const BasicAnimationHome({Key? key}) : super(key: key);

  static const routeName = '/basic_animation_home';
  @override
  State<BasicAnimationHome> createState() => _BasicAnimationHomeState();
}

class _BasicAnimationHomeState extends State<BasicAnimationHome> {
  final double _headerHeight = 220;
  final _listKey = GlobalKey<AnimatedListState>();
  final _offsetTween = Tween(begin: const Offset(0.5, 0), end: Offset.zero).chain(
    CurveTween(curve: Curves.fastOutSlowIn),
  );

  var ft = Future(() {});
  final List<PokemonData> _pokemonListTiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pokemonsData.forEach(initpokemons);
    });
  }

  void initpokemons(PokemonData pokemon) {
    ft = ft.then((_) {
      return Future.delayed(const Duration(milliseconds: 50), () {
        addpokemon(pokemon);
      });
    });
  }

  void addpokemon(PokemonData pokemon) {
    final nextIndex = _pokemonListTiles.length;
    _pokemonListTiles.add(pokemon);
    _listKey.currentState?.insertItem(nextIndex);
  }

  void removepokemon(int index) {
    var removedItem = _pokemonListTiles[index];
    _pokemonListTiles.removeAt(index);
    _listKey.currentState?.removeItem(index, (context, animation) {
      return FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: PokemonTile(index, pokemon: removedItem, onDelete: (idx) {}),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildHeader(context),
          SizedBox(
            height: MediaQuery.of(context).size.height - _headerHeight,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _pokemonListTiles.length,
              itemBuilder: (BuildContext context, int index, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: animation.drive(_offsetTween),
                    child: PokemonTile(index, pokemon: _pokemonListTiles[index], onDelete: removepokemon),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildHeader(BuildContext context) {
    return Container(
      height: _headerHeight,
      width: double.infinity,
      color: Colors.deepPurple.shade400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: TweenAnimationBuilder(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 500),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (BuildContext context, dynamic value, Widget? child) {
                return Opacity(
                  opacity: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: value * 20),
                    child: child,
                  ),
                );
              },
              child: Text(
                'My Pokemons',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                    onPressed: () {
                      var randompokemon = (List.of(pokemonsData)..shuffle()).first;
                      var pokemon = PokemonData(
                        id: DateTime.now().toString(),
                        name: randompokemon.name,
                        age: randompokemon.age,
                        power: randompokemon.power,
                      );

                      _pokemonListTiles.insert(0, pokemon);
                      _listKey.currentState?.insertItem(0);
                    },
                    child: const Text('Add Item')),
              ),
            ],
          ),
          const SizedBox(height: 12)
        ],
      ),
    );
  }
}

class PokemonTile extends StatelessWidget {
  final int index;
  final PokemonData pokemon;
  final void Function(int) onDelete;
  const PokemonTile(
    this.index, {
    Key? key,
    required this.pokemon,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // contentPadding: EdgeInsets.all(0),
      // minVerticalPadding: 0,
      // horizontalTitleGap: 0,
      leading: Hero(
        tag: 'pokemon-${pokemon.id}',
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: SizedBox(
            height: double.infinity,
            width: 60,
            child: Image.asset(
              LocalAssets.backgroundNeonRed,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(pokemon.name),
      subtitle: Text('Age: ${pokemon.age} - Power: ${pokemon.power}'),
      trailing: SizedBox(
        width: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: () => onDelete(index), icon: const Icon(Icons.delete)),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, PokemonDetailsPage.routeName, arguments: pokemon);
      },
    );
  }
}
