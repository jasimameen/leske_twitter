import 'package:flutter/material.dart';

class Messanger {
  static final _instance = GlobalKey<ScaffoldMessengerState>();

  static getInstance() => _instance;

  static final _currentState = _instance.currentState!;

  static showSnackBar(String message) {
    _currentState.removeCurrentSnackBar();
    _currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'close',
          onPressed: () => _currentState.removeCurrentSnackBar(),
        ),
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
