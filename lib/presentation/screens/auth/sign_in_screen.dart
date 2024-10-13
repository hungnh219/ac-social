import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/data/models/auth/sign_in_user_req.dart';
import 'package:social_app/mixin/validators/validators.dart';
import 'package:social_app/presentation/widgets/auth_body.dart';
import 'package:social_app/presentation/widgets/auth_elevated_button.dart';
import 'package:social_app/presentation/widgets/auth_header_image.dart';
import 'package:social_app/presentation/widgets/auth_text_form_field.dart';
import 'package:social_app/service_locator.dart';
import 'package:social_app/utils/styles/colors.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repository/auth/auth.dart';

class SignInScreen extends StatefulWidget with Validator {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late ValueNotifier<bool> _obscureText;
  late ValueNotifier<bool> _isLoading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureText = ValueNotifier<bool>(true);
    _isLoading = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
          const AuthHeaderImage(height: 0.4),
          CustomBody(
            marginTop: MediaQuery.of(context).size.height * 0.3,
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
                        CustomTextFormField(
                          textEditingController: _emailController,
                          hintText: "Email",
                          textInputAction: TextInputAction.next,
                          validator: (value) => widget.validateEmail(value),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ValueListenableBuilder(
                          valueListenable: _obscureText,
                          builder: (context, value, child) {
                            return CustomTextFormField(
                              textEditingController: _passwordController,
                              hintText: "Password",
                              obscureText: value,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (widget.validateEmpty(value)) {
                                  return "Please enter a your password";
                                }
                                return null;
                              },
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
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "FORGOT PASSWORD",
                      style: TextStyle(
                          color: AppColors.iric,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                          fontSize: 14),
                    ),
                  ),
                  CustomElevatedButton(
                    width: double.infinity,
                    height: 52,
                    inputText: "LOG IN",
                    onPressed: () {
                      _login(context);
                    },
                    isLoading: _isLoading,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "OR LOG IN BY",
                      style: TextStyle(
                        color: AppColors.kettleman,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.lavenderMist,
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(colors: [
                            AppColors.iric,
                            AppColors.lavenderBlueShadow,
                          ]).createShader(bounds);
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
                      const Text(
                        "Don't have account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () => context.go("/signup"),
                        child: const Text(
                          "SIGN UP",
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
        ],
      ),
    );
  }

  void _login(BuildContext context) async {
    _isLoading.value = true;
    try {
      if (_formKey.currentState!.validate()) {
        await serviceLocator<AuthRepository>().signInWithEmailAndPassword(
            SignInUserReq(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim()));
      }
      _showAlertDialog(context, "Success", "Login success");
    } catch (e) {
      _showAlertDialog(context, "Error", e.toString());
    } finally {
      _isLoading.value = false;
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
