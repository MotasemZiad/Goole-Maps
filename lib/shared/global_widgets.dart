import 'package:flutter/material.dart';

class GlobalWidgets {
  GlobalWidgets._();
  static final globalWidgets = GlobalWidgets._();

  void showSnackBar({
    @required BuildContext context,
    @required String content,
    Color backgroundColor,
    int duration = 1500,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(content),
        backgroundColor: backgroundColor,
        duration: Duration(
          milliseconds: duration,
        ),
      ),
    );
  }
}
