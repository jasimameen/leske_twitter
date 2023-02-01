import 'package:flutter/material.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/features/splash/view/splash_view.dart';

import 'features/auth/view/login_view.dart';
import 'features/auth/view/signup_view.dart';

class Routes {
  static const initialRoute = SplashView.routeName;
  
  static final routes = <String, WidgetBuilder>{
    SplashView.routeName:(context) => const SplashView(),
    LoginView.routeName: (context) => const LoginView(),
    SignUpView.routeName: (context) => const SignUpView(),
    HomeView.routeName:(context) => const HomeView(),

    // helper pages
    LoadingPage.routeName :(context) => const LoadingPage(),
    ErrorPage.routeName:(context) => const ErrorPage(),
  };
}
