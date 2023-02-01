import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/utils/messengers/messenger.dart';
import 'core/utils/navigation/navigation.dart';
import 'routes.dart';
import 'theme/app_theme.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Navigation.getInstance(),
      scaffoldMessengerKey: Messanger.getInstance(),
      title: 'Leske Twitter',
      theme: AppTheme.theme,
      themeMode: ThemeMode.dark,
      initialRoute: Routes.initialRoute,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
