import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_bili_f/util/color.dart';

@immutable
class LoginButton extends StatelessWidget {
  final String title;
  bool enable;
  final VoidCallback? onPressed;

  LoginButton(this.title, {Key? key, this.enable = false, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        onPressed: enable ? onPressed : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        height: 65,
        disabledColor: primary[50],
        color: primary,
        child: Text(title),
        textColor: white,
        disabledTextColor: Colors.white,
      ),
    );
  }
}
