import 'package:flutter/material.dart';
import 'features/auth/view/login_view.dart';
import 'features/auth/view/signup_view.dart';

class Routes {
  static const initialRoute = LoginView.routeName;
  
  static final routes = <String, WidgetBuilder>{
    LoginView.routeName: (context) => const LoginView(),
    SignUpView.routeName: (context) => const SignUpView(),
  };
}
