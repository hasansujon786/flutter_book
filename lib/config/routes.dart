import 'package:flutter_book/pages/home.dart';
import 'package:flutter_book/pages/sliver.dart';

routes() {
  return {
    '/': (context) => const HomePage(),
    SliverPage.routeName: (context) => const SliverPage(),
  };
}
