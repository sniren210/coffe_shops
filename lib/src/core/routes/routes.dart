import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/pin',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const MyHomePage(title: 'Flutter Demo Home Page'),
    ),
    GoRoute(
      path: '/pin',
      builder: (context, state) => const PinPage(),
    ),
  ],
  redirect: (context, state) {
    final loggedIn = preferences?.getBool('isLogin') ?? false;

    if (!loggedIn) {
      return '/pin';
    }

    if (loggedIn) {
      return '/';
    }
  },
);
