import 'package:flutter/material.dart';

import 'models/ninja.dart';
import '../../pages.dart';

class BasicAnimationHome extends StatefulWidget {
  const BasicAnimationHome({Key? key}) : super(key: key);

  static const routeName = '/basic_animation_home';
  @override
  _BasicAnimationHomeState createState() => _BasicAnimationHomeState();
}

class _BasicAnimationHomeState extends State<BasicAnimationHome> {
  final double _headerHeight = 220;
  final _listKey = GlobalKey<AnimatedListState>();
  final _offsetTween = Tween(begin: const Offset(0.5, 0), end: Offset.zero).chain(
    CurveTween(curve: Curves.fastOutSlowIn),
  );

  var ft = Future(() {});
  final List<NinjaData> _ninjaListTiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ninjasData.forEach(initNinjas);
    });
  }

  void initNinjas(NinjaData ninja) {
    ft = ft.then((_) {
      return Future.delayed(const Duration(milliseconds: 50), () {
        addNinja(ninja);
      });
    });
  }

  void addNinja(NinjaData ninja) {
    final nextIndex = _ninjaListTiles.length;
    _ninjaListTiles.add(ninja);
    _listKey.currentState?.insertItem(nextIndex);
  }

  void removeNinja(int index) {
    var removedItem = _ninjaListTiles[index];
    _ninjaListTiles.removeAt(index);
    _listKey.currentState?.removeItem(index, (context, animation) {
      return FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: NinjaTile(index, ninja: removedItem, onDelete: (idx) {}),
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
              initialItemCount: _ninjaListTiles.length,
              itemBuilder: (BuildContext context, int index, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: animation.drive(_offsetTween),
                    child: NinjaTile(index, ninja: _ninjaListTiles[index], onDelete: removeNinja),
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
              child: Text(
                'Net Ninja',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
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
                      var _ninja = (List.of(ninjasData)..shuffle()).first;
                      var ninja = NinjaData(
                        id: DateTime.now().toString(),
                        name: _ninja.name,
                        age: _ninja.age,
                        power: _ninja.power,
                      );

                      _ninjaListTiles.insert(0, ninja);
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

class NinjaTile extends StatelessWidget {
  final int index;
  final NinjaData ninja;
  final void Function(int) onDelete;
  const NinjaTile(
    this.index, {
    Key? key,
    required this.ninja,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // contentPadding: EdgeInsets.all(0),
      // minVerticalPadding: 0,
      // horizontalTitleGap: 0,
      leading: Hero(
        tag: 'ninja-${ninja.id}',
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: SizedBox(
            height: double.infinity,
            width: 60,
            child: Image.network(
              'https://images.pexels.com/photos/3566120/pexels-photo-3566120.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(ninja.name),
      subtitle: Text('Age: ${ninja.age} - Power: ${ninja.power}'),
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
        Navigator.pushNamed(context, NinjaPage.routeName, arguments: ninja);
      },
    );
  }
}
