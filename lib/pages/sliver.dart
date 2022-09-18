import 'dart:io';

import 'package:flutter/material.dart';

class SliverPage extends StatefulWidget {
  const SliverPage({Key? key}) : super(key: key);

  static const routeName = '/sliver-page';

  @override
  State<SliverPage> createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  var top = 0.0;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildAppBar(),
              _buildContents(),
            ],
          ),
          _buildFab()
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      leading: const SizedBox(),
      pinned: true,
      stretch: true,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Image.network(
          'https://images.pexels.com/photos/3566120/pexels-photo-3566120.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
          fit: BoxFit.cover,
        ),
        title: LayoutBuilder(
          builder: (ctx, cons) {
            top = cons.biggest.height;
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: top <= 200 ? 1.0 : 0.0,
              child: Row(
                children: const [
                  SizedBox(width: 12),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260'),
                  ),
                  SizedBox(width: 12),
                  Text('Fluttercraft')
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFab() {
    double defaultMargin = Platform.isIOS ? 270 : 250;
    double defaultStart = 230;
    double defaultEnd = defaultStart / 2;

    var top = defaultMargin;
    var scale = 1.0;

    if (_scrollController.hasClients) {
      double offSet = _scrollController.offset;
      top -= offSet;

      if (offSet < defaultMargin - defaultStart) {
        scale = 1;
      } else if (offSet < defaultMargin - defaultEnd) {
        scale = (defaultMargin - defaultEnd - offSet) / defaultEnd;
      } else {
        scale = 0;
      }
    }

    return Positioned(
      top: top,
      right: 20,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 280),
        opacity: scale <= 0.85 ? 0 : 1,
        child: Transform(
          transform: Matrix4.identity()..scale(scale),
          alignment: Alignment.center,
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.camera),
          ),
        ),
      ),
    );
  }

  Widget _buildContents() {
    return SliverToBoxAdapter(
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: 50,
        itemBuilder: (ctx, i) {
          return const ListTile(
            leading: FlutterLogo(),
            title: Text('Flutter'),
            subtitle: Text('Subtitle'),
          );
        },
      ),
    );
  }
}
