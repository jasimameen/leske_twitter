import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/core/utils/messengers/messenger.dart';
import 'package:twitter_clone/core/utils/navigation/navigation.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../../common/common.dart';
import '../../auth/view/login_view.dart';

class SplashView extends ConsumerStatefulWidget {
  static const routeName = '/';
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        ref.watch(currentUserAccoundProvider).when(
              data: (user) {
                if (user == null) {
                  Navigation.route.pushReplacementNamed(LoginView.routeName);
                }
                Navigation.route.pushReplacementNamed(HomeView.routeName);
              },
              error: (error, _) =>
                  Navigation.route.pushReplacementNamed(ErrorPage.routeName),
              loading: () {
                Messanger.showSnackBar('please be patient!!');
              },
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * .25;
    return Scaffold(
      backgroundColor: Pallete.blueColor,
      body: Center(
        child: FaIcon(
          FontAwesomeIcons.twitter,
          size: size,
          color: Colors.white,
        ),
      ),
    );
  }
}
