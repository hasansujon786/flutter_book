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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: _headerHeight,
            width: double.infinity,
            color: Colors.deepPurple.shade400,
            child: Padding(
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
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - _headerHeight,
            child: ListView.builder(
              itemCount: ninjas.length,
              itemBuilder: (BuildContext context, int index) {
                return NinjaTile(ninja: ninjas[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NinjaTile extends StatelessWidget {
  final Ninja ninja;
  const NinjaTile({
    Key? key,
    required this.ninja,
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
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pushNamed(context, NinjaPage.routeName, arguments: ninja);
      },
    );
  }
}
