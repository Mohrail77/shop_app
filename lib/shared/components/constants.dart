import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

void signout(context) {
  CashHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false);
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
