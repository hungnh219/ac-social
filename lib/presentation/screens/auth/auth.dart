import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'cubit/auth_cubit.dart';
import 'cubit/auth_state.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // Giữ cho việc build hoàn tất
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is Authenticated) {
            // Chuyển đến màn hình home khi đã đăng nhập trước đó
            context.go("/signin/home");
          } else if (state is Unauthenticated) {
            context.go("/signin");
          }
        });
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
