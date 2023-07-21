import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman/blocs/game_bloc/game_bloc.dart';
import '../screens/screens.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/score',
    builder: (context, state) => const ScoreScreen(),
  ),
  GoRoute(
    path: '/game',
    builder: (context, state) {
      final name = state.extra as Map;
      return BlocProvider(
        create: (context) => GameBloc(),
        child: GameScreen(name: name['name'] as String),
      );
    },
  ),
]);
