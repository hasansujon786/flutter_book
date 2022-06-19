import 'package:flutter/material.dart';
import 'package:flutter_book/pages/animation/basic/models/ninja.dart';

class NinjaPage extends StatefulWidget {
  const NinjaPage({Key? key}) : super(key: key);

  static const routeName = '/ninja';
  @override
  _NinjaPageState createState() => _NinjaPageState();
}

class _NinjaPageState extends State<NinjaPage> {
  @override
  Widget build(BuildContext context) {
    final ninja = ModalRoute.of(context)!.settings.arguments as Ninja;

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
            trailing: const Icon(Icons.favorite),
            onTap: () {
              // Navigator.pushNamed(context, NinjaPage.routeName);
            },
          )
        ],
      ),
    );
  }
}
