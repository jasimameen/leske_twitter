import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import 'assets_constants.dart';

class UIConstants {
  static get appBar => AppBar(
        title: SvgPicture.asset(
          AssetsConstants.twitterLogo,
          color: Pallete.blueColor,
          height: 30,
        ),
        centerTitle: true,
      );

  static List<Widget> bottomTabBarPages = const [
    Text('news feed'),
    Text('search'),
    Text('twitter circle'),
    Text('notifications'),
    Text('message'),
  ];
}
