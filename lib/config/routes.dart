import '../pages/pages.dart';

routes() {
  return {
    '/': (context) => const HomePage(),
    SliverPage.routeName: (context) => const SliverPage(),
    BasicAnimationHome.routeName: (context) => const BasicAnimationHome(),
    PokemonDetailsPage.routeName: (context) => const PokemonDetailsPage(),
    StaggeredProfilePageAnimator.routeName: (context) => const StaggeredProfilePageAnimator(),
    FacePileScreen.routeName: (context) => const FacePileScreen(),
    ParallaxList.routeName: (context) => const ParallaxList(),
  };
}
