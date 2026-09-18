import 'package:flutter_book/animating_drawer/presentation/widgets/drawer.dart';
import 'package:flutter_book/core/route_names.dart';
import 'package:flutter_book/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(path: Routes.home, builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: Routes.animatingDrawer,
      builder: (context, state) => const AnimatingScaleDrawer(),
    ),
  ],
);
