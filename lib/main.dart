import 'package:flutter/material.dart';
import 'core/navigation/navigation.dart';
import 'routes.dart';
import 'theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Navigation.instance,
      title: 'Leske Twitter',
      theme: AppTheme.theme,
      themeMode: ThemeMode.dark,
      initialRoute: Routes.initialRoute,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
