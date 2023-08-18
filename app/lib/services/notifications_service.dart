import 'package:flutter/material.dart';

class NotificationsService {
  static late GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(String message,
      {Color backgroundColor = Colors.black,
      Color textColor = Colors.white,
      int type = 1}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
      backgroundColor: backgroundColor,
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
