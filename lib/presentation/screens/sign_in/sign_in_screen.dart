import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/data/models/auth/sign_in_user_req.dart';
import 'package:social_app/mixin/validators/validators.dart';
import 'package:social_app/presentation/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:social_app/presentation/screens/sign_in/cubit/sign_in_state.dart';
import 'package:social_app/utils/styles/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/utils/styles/themes.dart';

import '../../../utils/constants/icon_path.dart';
import '../../widgets/auth/auth_body.dart';
import '../../widgets/auth/auth_elevated_button.dart';
import '../../widgets/auth/auth_header_image.dart';
import '../../widgets/auth/auth_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with Validator {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late ValueNotifier<bool> _obscureText;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureText = ValueNotifier<bool>(true);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _obscureText.dispose();
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
                  style: AppTheme.authHeaderStyle,
                ),
              ),
            ),
          ),
          AuthBody(
            marginTop: MediaQuery.of(context).size.height * 0.34,
            height: double.infinity,
            padding: Padding(
              padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
              child: BlocBuilder<SignInCubit, SignInState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Form(
                        key: context.read<SignInCubit>().formKey,
                        child: Column(
                          children: [
                            AuthTextFormField(
                              textEditingController: _emailController,
                              hintText: "Email",
                              textInputAction: TextInputAction.next,
                              validator: (value) => validateEmail(value),
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
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (validateEmpty(value)) {
                                      return "Please enter a your password";
                                    }
                                    return null;
                                  },
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _obscureText.value = !value;
                                    },
                                    icon: Icon(value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "FORGOT PASSWORD",
                          style: AppTheme.authForgotStyle,
                        ),
                      ),
                      AuthElevatedButton(
                        width: double.infinity,
                        height: 45,
                        inputText: "LOG IN",
                        onPressed: () => context
                            .read<SignInCubit>()
                            .loginWithEmailAndPassword(
                              context,
                              SignInUserReq(
                                  email: _emailController.text,
                                  password: _passwordController.text),
                            ),
                        isLoading: (state is SignInLoading ? true : false),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "OR LOG IN BY",
                          style: AppTheme.authNormalStyle,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => context
                            .read<SignInCubit>()
                            .loginWithGoogle(context),
                        icon: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.lavenderMist,
                          ),
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return AppTheme.mainGradient.createShader(bounds);
                            },
                            child: SvgPicture.asset(
                              AppIcons.googleLogo,
                              width: 20.0,
                              height: 20.0,
                              color: const Color.fromARGB(255, 89, 28, 219),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have account?",
                            style: AppTheme.authSignUpStyle
                                .copyWith(color: AppColors.kettleman),
                          ),
                          TextButton(
                            onPressed: () => context.go("/signin/signup"),
                            child: Text(
                              "SIGN UP",
                              style: AppTheme.authSignUpStyle,
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
