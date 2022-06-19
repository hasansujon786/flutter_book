import '../pages/pages.dart';

routes() {
  return {
    '/': (context) => const HomePage(),
    SliverPage.routeName: (context) => const SliverPage(),
    BasicAnimationHome.routeName: (context) => const BasicAnimationHome(),
    NinjaPage.routeName: (context) => const NinjaPage(),
  };
}
