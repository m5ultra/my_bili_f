import 'package:flutter/material.dart';
import 'package:my_bili_f/pages/login_page.dart';
import 'package:my_bili_f/util/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: white,
      ),
      // home: const RegistrationPage(),
      home: const LoginPage(),
    );
  }
}
