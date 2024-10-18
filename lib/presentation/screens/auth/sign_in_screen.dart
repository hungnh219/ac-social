import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/data/models/auth/sign_in_user_req.dart';
import 'package:social_app/mixin/validators/validators.dart';
import 'package:social_app/service_locator.dart';
import 'package:social_app/utils/styles/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/utils/styles/themes.dart';

import '../../../data/sources/firestore/firestore_service.dart';
import '../../../domain/repository/auth/auth.dart';
import '../../../domain/repository/user/user.dart';
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
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late ValueNotifier<bool> _obscureText;
  late ValueNotifier<bool> _isLoading;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureText = ValueNotifier<bool>(true);
    _isLoading = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _obscureText.dispose();
    _isLoading.dispose();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
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
                    onPressed: () {
                      _login(context);
                    },
                    isLoading: _isLoading,
                  ),
                  TextButton(
                    onPressed: () {},
                    child:
                        Text("OR LOG IN BY", style: AppTheme.authNormalStyle),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _loginWithGoogle(context);
                    },
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
                          "assets/icons/google_logo.svg",
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
                        onPressed: () => context.go("/signup"),
                        child: Text(
                          "SIGN UP",
                          style: AppTheme.authSignUpStyle,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login(BuildContext context) async {
    _isLoading.value = true;
    try {
      if (_formKey.currentState!.validate()) {
        try {
          await serviceLocator<AuthRepository>().signInWithEmailAndPassword(
            SignInUserReq(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );

          final userModel =
              await serviceLocator<UserRepository>().getCurrentUserData();

          if (!mounted) return;
          _showAlertDialog(context, 'Success', 'Login success');
        } catch (e) {
          if (e == 'new-user') {
            if (!mounted) return;
            _showAlertDialog(context, 'Navigator',
                'Login success, navigator to choose category screen');
          } else {
            rethrow;
          }
        } finally {
          _isLoading.value = false;
        }
      }
    } catch (e) {
      if (!mounted) return;
      _showAlertDialog(context, "Error", e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void _loginWithGoogle(BuildContext context) async {
    try {
      await serviceLocator<AuthRepository>().signInWithGoogle();
      final userModel =
          await serviceLocator<UserRepository>().getCurrentUserData();

      if (!mounted) return;
      _showAlertDialog(context, "Success", "Login success");
    } catch (e) {
      if (e is CustomFirestoreException) {
        if (e.message == 'new-user') {
          if (!mounted) return;
          _showAlertDialog(context, 'Navigator',
              'Login success, navigator to choose category screen');
        }
      }
      else {
        throw Exception(e);
      }
    }
  }

  void _showAlertDialog(BuildContext context, String? title, String? message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "$title",
            textAlign: TextAlign.center,
          ),
          content: Text("$message"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }
}
