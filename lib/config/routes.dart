import '../pages/pages.dart';

routes() {
  return {
    '/': (context) => const HomePage(),
    SliverPage.routeName: (context) => const SliverPage(),
    BasicAnimationHome.routeName: (context) => const BasicAnimationHome(),
    CustomAnimation.routeName: (context) => const CustomAnimation(),
    PokemonDetailsPage.routeName: (context) => const PokemonDetailsPage(),
    StaggeredProfilePageAnimator.routeName: (context) => const StaggeredProfilePageAnimator(),
    FacePileScreen.routeName: (context) => const FacePileScreen(),
    ParallaxList.routeName: (context) => const ParallaxList(),
    BasicClipPathExample.routeName: (context) => const BasicClipPathExample(),
    AdvancedBazierCurve.routeName: (context) => const AdvancedBazierCurve(),
    CarouselExamples.routeName: (context) => const CarouselExamples(),
    ControllerPattern.routeName: (context) => const ControllerPattern(),
  };
}
