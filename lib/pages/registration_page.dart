import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_bili_f/http/dao/login_dao.dart';
import 'package:my_bili_f/model/res_registration.dart';
import 'package:my_bili_f/util/color.dart';
import 'package:my_bili_f/util/utils.dart';
import 'package:my_bili_f/widget/appbar.dart';
import 'package:my_bili_f/widget/login_effect.dart';
import 'package:my_bili_f/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();

  void onJumpLogin() {
    print('right btn click');
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  String userName = '';
  String password = '';
  String rePassword = '';
  String imoocId = '';
  String orderId = '';

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: loginEnable ? _handleRegistration : null,
      child: const Text(
        '注册',
        style: TextStyle(fontSize: 18, color: primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        '注册',
        '登录',
        widget.onJumpLogin,
      ),
      body: Center(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              title: '姓名',
              hint: '请输入姓名',
              keyboardType: TextInputType.text,
              onChange: (val) {
                userName = val;
                _checkParams();
              },
              focusChanged: (isFalsity) {},
            ),
            LoginInput(
              title: '密码',
              hint: '请输入密码',
              obscureText: true,
              keyboardType: TextInputType.text,
              onChange: (val) {
                password = val;
                _checkParams();
              },
              focusChanged: (isFocus) {
                setState(() {
                  protect = isFocus;
                });
              },
            ),
            LoginInput(
              title: '确认密码',
              hint: '请确认密码',
              obscureText: true,
              keyboardType: TextInputType.text,
              onChange: (val) {
                rePassword = val;
                _checkParams();
              },
              focusChanged: (isFocus) {
                protect = isFocus;
              },
            ),
            LoginInput(
              title: '幕客网ID',
              hint: '请幕客网ID',
              keyboardType: TextInputType.number,
              onChange: (val) {
                imoocId = val;
                _checkParams();
              },
              focusChanged: (isFalsity) {},
            ),
            LoginInput(
              title: '课程ID',
              hint: '请输入课程ID',
              keyboardType: TextInputType.number,
              onChange: (val) {
                orderId = val;
                _checkParams();
              },
              focusChanged: (isFalsity) {},
            ),
            Container(
              height: 70,
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: _loginButton(),
            ),
          ],
        ),
      ),
    );
  }

  void _checkParams() {
    setState(() {
      loginEnable = Utils.isNotEmpty(userName) &&
          Utils.isNotEmpty(password) &&
          Utils.isNotEmpty(rePassword) &&
          Utils.isNotEmpty(imoocId) &&
          Utils.isNotEmpty(orderId);
    });
  }

  _handleRegistration() {
    if (password == rePassword) {
      _send();
    } else {
      print('密码不一致');
    }
  }

  void _send() async {
    final res = RegistrationResult.fromJson(
        await LoginDao.registration(userName, password, imoocId, orderId));
    if (res.code == 0) {
      Fluttertoast.showToast(
          msg: "注册成功。",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: white,
          textColor: primary,
          fontSize: 16.0);
    }

    Timer.periodic(const Duration(milliseconds: 1500), (t) {
      Fluttertoast.cancel();
      t.cancel();
      print('=======跳转到登录页面，带上用户账户和密码=======');
    });
  }
}
