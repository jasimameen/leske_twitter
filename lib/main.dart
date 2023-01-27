import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leske Twitter',
      theme: AppTheme.theme ,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Leske Twitter'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      )
    );
  }
}