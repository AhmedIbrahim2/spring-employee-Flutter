import 'package:flutter/material.dart';
import 'package:ocr_test/login.dart';
import 'package:ocr_test/register.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(
              context: context,
            ),
        '/register': (context) => RegisterPage(context: context),
        '/userList': (context) => UserListScreen(),
      },
    );
  }
}
