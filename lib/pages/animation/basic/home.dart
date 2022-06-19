import 'package:flutter/material.dart';

import 'models/ninja.dart';
import '../../pages.dart';

class BasicAnimationHome extends StatefulWidget {
  const BasicAnimationHome({Key? key}) : super(key: key);

  static const routeName = '/basic_animation_home';
  @override
  _BasicAnimationHomeState createState() => _BasicAnimationHomeState();
}

class _BasicAnimationHomeState extends State<BasicAnimationHome> with SingleTickerProviderStateMixin {
  final double _headerHeight = 220;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    final _curveAnimation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _slideAnimation = Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0)).animate(_curveAnimation);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });

    // _controller.addListener(() {
    //   setState(() {});
    // });
  }

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
              padding: const EdgeInsets.only(top: 70, left: 20),
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  'Net Ninja',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                ),
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
