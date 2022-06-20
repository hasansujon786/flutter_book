import 'package:flutter/material.dart';

import './pages.dart';

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
      backgroundColor: Colors.deepPurple.shade300,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  primary: false,
                  shrinkWrap: true,
                  children: [
                    _buildLink('Sliver App Bar', SliverPage.routeName),
                    _buildLink('Basic Animation', BasicAnimationHome.routeName),
                    _buildLink('Staggered Profile Page', StaggeredProfilePageAnimator.routeName),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.deepPurple[400],
      pinned: true,
      stretch: true,
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Row(
          children: const [
            SizedBox(width: 12),
            CircleAvatar(child: FlutterLogo(), backgroundColor: Colors.white12),
            SizedBox(width: 12),
            Text('Flutter Book')
          ],
        ),
      ),
    );
  }

  Widget _buildLink(String title, String path) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ListTile(
        onTap: () {
          Navigator.restorablePushNamed(context, path);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        tileColor: Colors.deepPurple[400],
        // minVerticalPadding: 30,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white30),
      ),
    );
  }
}
