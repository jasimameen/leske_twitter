import 'package:flutter/material.dart' show NavigatorState, GlobalKey;

class Navigation {
  static final _instance = GlobalKey<NavigatorState>();

  static getInstance() => _instance;

  static NavigatorState get route => _instance.currentState!;
}
