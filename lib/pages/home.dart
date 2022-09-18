import 'package:flutter/material.dart';

import './pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: ListView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  primary: false,
                  shrinkWrap: true,
                  children: [
                    _buildLink('Sliver App Bar', SliverPage.routeName),
                    _buildLink('Basic Animation', BasicAnimationHome.routeName),
                    _buildLink('Staggered Profile Page', StaggeredProfilePageAnimator.routeName),
                    _buildLink('Face Pile', FacePileScreen.routeName),
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
        titlePadding: const EdgeInsets.symmetric(vertical: 12),
        title: Row(
          children: const [
            SizedBox(width: 12),
            CircleAvatar(backgroundColor: Colors.white12, child: FlutterLogo()),
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
