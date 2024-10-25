import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:social_app/presentation/screens/auth/auth.dart';
import 'package:social_app/presentation/screens/boarding/boarding.dart';
import 'package:social_app/presentation/screens/category/category_screen.dart';
import 'package:social_app/presentation/screens/forgot_pasword/forgot_password_screen.dart';
import 'package:social_app/presentation/screens/comment/comment_screen.dart';
import 'package:social_app/presentation/screens/comment/comment_screen.dart';
import 'package:social_app/presentation/screens/home/home_screen.dart';
import 'package:social_app/presentation/screens/new_post/new_post_screen.dart';
import 'package:social_app/presentation/screens/splash/splash.dart';
import 'package:social_app/presentation/widgets/navigator_bar.dart';

import '../../presentation/screens/forgot_pasword/forgot_password_screen.dart';
import '../../presentation/screens/edit_profile/edit_profile_screen.dart';
import '../../presentation/screens/sign_in/cubit/sign_in_cubit.dart';
import '../../presentation/screens/sign_in/sign_in_screen.dart';
import '../../presentation/screens/sign_up/sign_up_screen.dart';
import '../../presentation/screens/verification/verification_screen.dart';
import '../../presentation/screens/home/home_screen.dart';

class MyRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return _wrapWithWillPopScope(context, const SplashScreen());
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'boarding',
            builder: (BuildContext context, GoRouterState state) {
              return _wrapWithWillPopScope(context, const BoardingScreen());
            },
          ),
          GoRoute(
            path: 'auth',
            builder: (BuildContext context, GoRouterState state) {
              return _wrapWithWillPopScope(context, const AuthScreen());
            },
          ),
          GoRoute(
            path: 'signin',
            builder: (BuildContext context, GoRouterState state) {
              return _wrapWithWillPopScope(
                context,
                BlocProvider(
                  create: (_) => SignInCubit(),
                  child: const SignInScreen(),
                ),
              );
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'signup',
                builder: (BuildContext context, GoRouterState state) {
                  return _wrapWithWillPopScope(context, const SignUpScreen());
                },
              ),
              GoRoute(
                path: 'forgotpassword',
                builder: (BuildContext context, GoRouterState state) {
                  return _wrapWithWillPopScope(context, const ForgotPasswordScreen());
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'verification',
                    builder: (BuildContext context, GoRouterState state) {
                      return _wrapWithWillPopScope(context, const VerificationScreen());
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'category',
                builder: (BuildContext context, GoRouterState state) {
                  return _wrapWithWillPopScope(context, const CategoryScreen());
                },
              ),
              GoRoute(
                path: 'home',
                builder: (BuildContext context, GoRouterState state) {
                  return _wrapWithWillPopScope(context, const HomeScreen());
                },
              ),
              GoRoute(
                path: 'navigator',
                builder: (BuildContext context, GoRouterState state) {
                  return _wrapWithWillPopScope(context, const NavigatorBarCustom());
                },
              ),
              GoRoute(
                path: 'edit',
                builder: (BuildContext context, GoRouterState state) {
                  return _wrapWithWillPopScope(context, EditProfile());
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'newpost',
                    builder: (BuildContext context, GoRouterState state) {
                      return const NewPostScreen();
                    },
                  ),
                ]
              ),
              GoRoute(
                path: 'navigator',
                builder: (BuildContext context, GoRouterState state) {
                  return const NavigatorBarCustom();
                },
              ),

              GoRoute(
                path: 'newpost',
                builder: (BuildContext context, GoRouterState state) {
                  return const NewPostScreen();
                },
              ),
            ],
          ),
          GoRoute(
            path: 'comment',
            builder: (BuildContext context, GoRouterState state) {
              return _wrapWithWillPopScope(context, const CommentScreen());
            },
          ),

        ],
      ),
    ],
  );

  static Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("Do you want to exit this application?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                SystemNavigator.pop();  // Exits the app
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false;
  }

  // Helper function to wrap screens with WillPopScope
  static Widget _wrapWithWillPopScope(BuildContext context, Widget screen) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: screen,
    );
  }
}
