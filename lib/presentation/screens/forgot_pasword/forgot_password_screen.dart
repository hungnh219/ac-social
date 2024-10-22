import 'package:flutter/material.dart';
import 'package:social_app/utils/styles/themes.dart';

import '../../../mixin/validators/validators.dart';
import '../../widgets/auth/auth_body.dart';
import '../../widgets/auth/auth_elevated_button.dart';
import '../../widgets/auth/auth_header_image.dart';
import '../../widgets/auth/auth_text_form_field.dart';
import '../../widgets/forgot_password/linear_gradient_title.dart';
import '../../widgets/forgot_password/message_content.dart';
import '../../widgets/forgot_password/stacks_bottom.dart';

class ForgotPasswordScreen extends StatefulWidget with Validator {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController _emailController;

  late ValueNotifier<bool> _isLoading;

  @override
  void initState() {
    _emailController = TextEditingController();
    _isLoading = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
      children: [
        const AuthHeaderImage(
          height: 0.38,
          childAspectRatio: 1.69,
        ),
        AuthBody(
          marginTop: MediaQuery.of(context).size.height * 0.28,
          height: double.infinity,
          padding: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                LinearGradientTitle(
                  text: "TYPE YOUR EMAIL",
                  textStyle: AppTheme.forgotPasswordLabelStyle,
                ),
                const SizedBox(
                  height: 15,
                ),
                const MessageContent(
                    text:
                        "We will send you instruction on how to reset your password"),
                const SizedBox(
                  height: 25,
                ),
                AuthTextFormField(
                  textEditingController: _emailController,
                  hintText: "Email",
                  textInputAction: TextInputAction.done,
                  validator: (value) => widget.validateEmail(value),
                ),
                const SizedBox(
                  height: 35,
                ),
                const AuthElevatedButton(
                  width: double.infinity,
                  height: 52,
                  inputText: "Send",
                  isLoading: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                const StacksBottom(),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
