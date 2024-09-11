import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:peach/config/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/views/App.dart';

/*
 * 启动欢迎页面
 */
class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Welcome();

  Welcome({Key key}) : super(key: key);
}

class _Welcome extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IntroViewsFlutter(
        Config.pages,
        onTapDoneButton: () {
          Config.isLogin ?
          Modular.to.pushReplacementNamed('/signUp') :
          Modular.to.pushReplacementNamed('/index');
        },
        skipText: Text("跳过"),
        doneText: Text("进入"),
        pageButtonTextStyles: TextStyle(
          color: Colors.white,
          fontSize: Screen.setFontSize(15.0),
        ),
      ), //IntroViewsFlutter
    );
  }

}
