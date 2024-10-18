import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/data/models/auth/create_user_req.dart';
import 'package:social_app/presentation/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:social_app/presentation/screens/sign_up/cubit/sign_up_state.dart';
import 'package:social_app/utils/styles/colors.dart';

import '../../widgets/auth/auth_body.dart';
import '../../widgets/auth/auth_elevated_button.dart';
import '../../widgets/auth/auth_header_image.dart';
import '../../widgets/auth/auth_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late ValueNotifier<bool> _obscureText;
  late ValueNotifier<bool> _obscureConfirmText;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _obscureText = ValueNotifier<bool>(true);
    _obscureConfirmText = ValueNotifier<bool>(true);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _obscureText.dispose();
    _obscureConfirmText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          AuthHeaderImage(
            height: 0.44,
            childAspectRatio: 1.33,
            positioned: Positioned.fill(
              top: -45,
              child: Center(
                child: Text(
                  "WELCOME",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 40,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2 // Độ dày của viền chữ
                      ..color = AppColors.white, // Màu viền
                  ),
                ),
              ),
            ),
          ),
          AuthBody(
            marginTop: MediaQuery.of(context).size.height * 0.34,
            height: double.infinity,
            padding: Padding(
              padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
              child: BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: context.read<SignUpCubit>().formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: [
                          AuthTextFormField(
                            textEditingController: _emailController,
                            hintText: "Email",
                            textInputAction: TextInputAction.next,
                            validator: (value) => context
                                .read<SignUpCubit>()
                                .validateEmailCubit(value),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ValueListenableBuilder(
                            valueListenable: _obscureText,
                            builder: (context, value, child) {
                              return AuthTextFormField(
                                textEditingController: _passwordController,
                                hintText: "Password",
                                obscureText: value,
                                textInputAction: TextInputAction.next,
                                validator: (value) => context
                                    .read<SignUpCubit>()
                                    .validatePasswordCubit(value),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _obscureText.value = !value;
                                  },
                                  icon: Icon(value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ValueListenableBuilder(
                            valueListenable: _obscureConfirmText,
                            builder: (context, value, child) {
                              return AuthTextFormField(
                                textEditingController:
                                    _confirmPasswordController,
                                hintText: "Password",
                                obscureText: value,
                                textInputAction: TextInputAction.done,
                                validator: (value) => context
                                    .read<SignUpCubit>()
                                    .validateConfirmPasswordCubit(
                                        _passwordController.text, value),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _obscureConfirmText.value = !value;
                                  },
                                  icon: Icon(value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    AuthElevatedButton(
                      width: double.infinity,
                      height: 45,
                      inputText: "SIGN IN",
                      onPressed: () => context.read<SignUpCubit>().signup(
                          context,
                          SignUpUserReq(
                              email: _emailController.text,
                              password: _passwordController.text)),
                      isLoading: (state is SignUpLoading ? true : false),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have account?",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () => context.go("/signin"),
                          child: const Text(
                            "SIGN IN",
                            style: TextStyle(
                                color: AppColors.iric,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
