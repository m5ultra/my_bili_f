import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_bili_f/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注册页面'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: [
              LoginInput(
                title: '姓名',
                hint: '请输入姓名',
                keyboardType: TextInputType.text,
                onChange: (val) {},
                focusChanged: (isFalsity) {},
              ),
              LoginInput(
                title: '密码',
                hint: '请输入密码',
                obscureText: true,
                keyboardType: TextInputType.text,
                onChange: (val) {},
                focusChanged: (isFalsity) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
