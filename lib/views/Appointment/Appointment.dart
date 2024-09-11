import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
 * 约稿
 */
class Appointment extends StatefulWidget {
  @override
  _Appointment createState() => _Appointment();
}

class _Appointment extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            "测试",
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
