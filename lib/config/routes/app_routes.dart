import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/presentation/screens/auth/auth.dart';
import 'package:social_app/presentation/screens/boarding/boarding.dart';
import 'package:social_app/presentation/screens/category/category_screen.dart';
import 'package:social_app/presentation/screens/forgot_pasword/forgot_password_screen.dart';
import 'package:social_app/presentation/screens/home/home_screen.dart';
import 'package:social_app/presentation/screens/splash/splash.dart';

import '../../presentation/screens/sign_in/sign_in_screen.dart';
import '../../presentation/screens/sign_up/sign_up_screen.dart';
import '../../presentation/screens/verification/verification_screen.dart';

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
            path: 'auth',
            builder: (BuildContext context, GoRouterState state) {
              return const AuthScreen();
            },
          ),
          GoRoute(
            path: 'signin',
            builder: (BuildContext context, GoRouterState state) {
              return const SignInScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'signup',
                builder: (BuildContext context, GoRouterState state) {
                  return const SignUpScreen();
                },
              ),
              GoRoute(
                path: 'forgotpassword',
                builder: (BuildContext context, GoRouterState state) {
                  return const ForgotPasswordScreen();
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'verification',
                    builder: (BuildContext context, GoRouterState state) {
                      return const VerificationScreen();
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'category',
                builder: (BuildContext context, GoRouterState state) {
                  return const CategoryScreen();
                },
              ),
              GoRoute(
                path: 'home',
                builder: (BuildContext context, GoRouterState state) {
                  return const HomeScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
