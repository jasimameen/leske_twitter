import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import '../../../core/navigation/navigation.dart';
import 'signup_view.dart';
import '../widgets/auth_field.dart';
import '../../../theme/theme.dart';

import '../../../core/common/common.dart';

class LoginView extends StatefulWidget {
  static const routeName = '/login';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  onLogin() {}

  @override
  Widget build(BuildContext context) {
    final isLoading = false;
    return Scaffold(
      appBar: UIConstants.appBar,
      body: Center(
        child: isLoading
            ? const Loader()
            : SingleChildScrollView(
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
                          onTap: onLogin,
                          label: 'Done',
                        ),
                      ),
                      const SizedBox(height: 40),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: ' Sign up',
                              style: const TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // redirect to signup view
                                  Navigation.state.pushNamed(SignUpView.routeName);
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
