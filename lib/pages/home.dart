import 'package:flutter/material.dart';

import 'package:flutter_book/pages/sliver.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.red[400],
      pinned: true,
      stretch: true,
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Row(
          children: const [
            SizedBox(width: 12),
            CircleAvatar(child: FlutterLogo(), backgroundColor: Colors.white60),
            SizedBox(width: 12),
            Text('Flutter Book')
          ],
        ),
      ),
    );
  }

  Widget _buildContents() {
    return SliverToBoxAdapter(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        primary: false,
        shrinkWrap: true,
        children: [
          ListTile(
            tileColor: Theme.of(context).cardColor,
            title: const Text('Sliver App Bar'),
            onTap: () {
              Navigator.restorablePushNamed(context, SliverPage.routeName);
            },
          )
        ],
      ),
    );
  }
}
