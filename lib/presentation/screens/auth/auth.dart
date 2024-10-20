import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_screen.dart';
import '../sign_in/sign_in_screen.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/auth_state.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const HomeScreen();
        } else if (state is Unauthenticated) {
          return SignInScreen();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
