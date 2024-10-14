import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/data/models/auth/create_user_req.dart';
import 'package:social_app/mixin/validators/validators.dart';
import 'package:social_app/utils/styles/colors.dart';

import '../../../domain/repository/auth/auth.dart';
import '../../../service_locator.dart';
import '../../widgets/auth/auth_body.dart';
import '../../widgets/auth/auth_elevated_button.dart';
import '../../widgets/auth/auth_header_image.dart';
import '../../widgets/auth/auth_text_form_field.dart';

class SignUpScreen extends StatefulWidget with Validator {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late ValueNotifier<bool> _obscureText;
  late ValueNotifier<bool> _obscureConfirmText;
  late ValueNotifier<bool> _isLoading;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _obscureText = ValueNotifier<bool>(true);
    _obscureConfirmText = ValueNotifier<bool>(true);
    _isLoading = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _obscureText.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          const AuthHeaderImage(
            height: 0.44,
            childAspectRatio: 1.33,
          ),
          AuthBody(
            marginTop: MediaQuery.of(context).size.height * 0.34,
            height: double.infinity,
            padding: Padding(
              padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _emailController,
                          builder: (context, value, child) => AuthTextFormField(
                            textEditingController: _emailController,
                            hintText: "Email",
                            textInputAction: TextInputAction.next,
                            validator: (value) => widget.validateEmail(value),
                          ),
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
                              validator: (value) =>
                                  widget.validatePassword(value),
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
                              textEditingController: _confirmPasswordController,
                              hintText: "Password",
                              obscureText: value,
                              textInputAction: TextInputAction.done,
                              validator: (value) =>
                                  widget.validateConfirmPassword(
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
                    onPressed: () {
                      _signup(context);
                    },
                    isLoading: _isLoading,
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
        ],
      ),
    );
  }

  void _signup(BuildContext context) async {
    _isLoading.value = true;
    try {
      if (_formKey.currentState!.validate()) {
        await serviceLocator<AuthRepository>().signUp(SignUpUserReq(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim()));
        _showAlertDialog(context, "Success",
            "An email has just been sent to you, click the link provided to complete registration");
      }
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
              child: const Text("Cancel"),
            )
          ],
        );
      },
    );
  }
}
