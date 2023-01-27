import 'package:flutter/material.dart' show NavigatorState, GlobalKey;

class Navigation {
  static final instance = GlobalKey<NavigatorState>();
  static NavigatorState get state => instance.currentState!;
}
