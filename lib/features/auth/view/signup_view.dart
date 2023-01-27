import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/navigation/navigation.dart';
import 'login_view.dart';

import '../../../core/common/common.dart';
import '../../../core/constants/constants.dart';
import '../../../theme/theme.dart';
import '../widgets/auth_field.dart';

class SignUpView extends StatefulWidget {
  static const routeName = '/sign-up';
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {}

  @override
  Widget build(BuildContext context) {
    final isLoading = false;

    return Scaffold(
      appBar: UIConstants.appBar,
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // textfield 1
                      AuthField(
                        controller: emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 25),
                      AuthField(
                        controller: passwordController,
                        hintText: 'Password',
                      ),
                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.topRight,
                        child: RoundedSmallButton(
                          onTap: onSignUp,
                          label: 'Done',
                        ),
                      ),
                      const SizedBox(height: 40),
                      RichText(
                        text: TextSpan(
                          text: "Already have an account?",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: ' Login',
                              style: const TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigation.state
                                      .pushNamed(LoginView.routeName);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
