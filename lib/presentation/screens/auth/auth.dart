import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/widgets/navigator_bar.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/navigator_bar.dart';
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
        // Giữ cho việc build hoàn tất
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is Authenticated) {
            // Chuyển đến màn hình home khi đã đăng nhập trước đó
            context.go("/signin/navigator");
          } else if (state is Unauthenticated) {
            context.go("/signin");
          }
        });
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
