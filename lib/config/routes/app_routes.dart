import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/presentation/screens/auth/sign_in_screen.dart';
import 'package:social_app/presentation/screens/boarding/boarding.dart';
import 'package:social_app/presentation/screens/splash/splash.dart';

import '../../presentation/screens/auth/sign_up_screen.dart';

class MyRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'boarding',
            builder: (BuildContext context, GoRouterState state) {
              return const BoardingScreen();
            },
          ),
          GoRoute(
            path: 'signin',
            builder: (BuildContext context, GoRouterState state) {
              return SignInScreen();
            },
          ),
          GoRoute(
            path: 'signup',
            builder: (BuildContext context, GoRouterState state) {
              return SignUpScreen();
            },
          ),
        ],
      ),
    ],
  );
}
