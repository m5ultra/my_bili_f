import 'package:flutter/material.dart';
import 'package:my_bili_f/db/hi_cache.dart';
import 'package:my_bili_f/http/dao/login_dao.dart';
import 'package:my_bili_f/model/login.dart';
import 'package:my_bili_f/util/utils.dart';
import 'package:my_bili_f/widget/appbar.dart';
import 'package:my_bili_f/widget/login_button.dart';
import 'package:my_bili_f/widget/login_effect.dart';
import 'package:my_bili_f/widget/login_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginEnable = false;
  bool protect = false;
  String userName = '';
  String password = '';

  _handleLogin() async {
    try {
      final res = Login.fromJson(await LoginDao.login(userName, password));
      if (res.success) {
        HiCache.getInstance()!.prefs!.setString('token', res.token);
      } else {
        print(res);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('密码登录', '注册', () {}),
        body: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              focusChanged: (bool v) {
                setState(() {
                  protect = false;
                });
              },
              title: '用户名',
              hint: '请输入用户名',
              keyboardType: TextInputType.text,
              onChange: (String v) {
                userName = v;
                _checkParams();
              },
            ),
            LoginInput(
              focusChanged: (isFocus) {
                setState(() {
                  protect = isFocus;
                });
              },
              title: '密码',
              hint: '请输入密码',
              obscureText: true,
              keyboardType: TextInputType.text,
              onChange: (String v) {
                password = v;
                _checkParams();
              },
            ),
            Container(
              height: 70,
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton(
                '登录',
                enable: loginEnable,
                onPressed: _handleLogin,
              ),
            )
          ],
        ));
  }

  void _checkParams() {
    setState(() {
      loginEnable = Utils.isNotEmpty(userName) && Utils.isNotEmpty(password);
    });
  }
}
