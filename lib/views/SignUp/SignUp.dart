import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/R.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/Screen.dart';
import 'dart:convert' as convert;

import 'package:peach/utils/_.dart';

/*
 * 首页
 */
class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> with SingleTickerProviderStateMixin {
  final List<String> _tabValues = [
    '登录',
    '注册',
  ];
  TabController tabController;

  String loginPhpne = '18305520337';
  String logingPass = '11111';

  String regPhpne = '15395283087';
  String regPass = '111111';
  String regName = '程睿是狗';

  @override
  void initState() {
    SPreferences.init();
    super.initState();
    tabController = new TabController(length: _tabValues.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: ColorConfig.WhiteBackColor,
        body: Stack(
          children: <Widget>[
            Positioned(
              height: Screen.setHeight(320),
              width: Screen.width(context),
              child: Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(R.libStaticSignupBackground),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 200,
              width: Screen.width(context),
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Container(
                  height: Screen.setHeight(300),
                  decoration: new BoxDecoration(
                    color: ColorConfig.WhiteBackColor,
                    borderRadius: new BorderRadius.vertical(
                        top: Radius.elliptical(5, 5),
                        bottom: Radius.elliptical(5, 5)),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConfig.ThemeOtherColor, //底色,阴影颜色
                        offset: Offset(0, 0), //阴影位置,从什么位置开始
                        blurRadius: 10, // 阴影模糊层度
                        spreadRadius: 2,
                      ) //阴影模糊大小
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 280,
                        height: Screen.setHeight(35),
                        child: TabBar(
                          unselectedLabelColor: ColorConfig.TextColor,
                          labelColor: ColorConfig.ThemeColor,
                          indicatorColor: ColorConfig.ThemeColor,
                          controller: tabController,
                          tabs: _tabValues
                              .asMap()
                              .keys
                              .map(
                                (e) => Tab(
                                    child: Text(
                                  _tabValues[e],
                                  style: TextStyle(fontSize: 18),
                                )),
                              )
                              .toList(),
                          onTap: (int i) {
                            // 触摸收起键盘
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                      ),
                      Container(
                        height:
                            Screen.setHeight(300) - Screen.setHeight(35) - 20,
                        margin: EdgeInsets.only(top: 10),
                        child: TabBarView(
                          controller: tabController,
                          children: <Widget>[login(), register()],
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget login() {
    return Padding(
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: [
            new Form(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "手机号",
                      hintText: "请输入手机号",
                      prefixIcon: Icon(
                        Icons.stay_current_portrait,
                        color: ColorConfig.ThemeColor,
                      ),
                      fillColor: ColorConfig.ThemeColor,
                      labelStyle: TextStyle(color: ColorConfig.ThemeColor),
                      focusedBorder: UnderlineInputBorder(
                        //选中时下边框颜色
                        borderSide: BorderSide(color: ColorConfig.ThemeColor),
                      ),
                    ),
                    onChanged: (str) => {
                      setState(() {
                        this.loginPhpne = str;
                      })
                    },
                  ),
                  new TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "请输入密码",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: ColorConfig.ThemeColor,
                      ),
                      fillColor: ColorConfig.ThemeColor,
                      labelStyle: TextStyle(color: ColorConfig.ThemeColor),
                      focusedBorder: UnderlineInputBorder(
                        //选中时下边框颜色
                        borderSide: BorderSide(color: ColorConfig.ThemeColor),
                      ),
                    ),
                    onChanged: (str) => {
                      setState(() {
                        this.logingPass = str;
                      })
                    },
                  ),
                  // new TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: "验证码",
                  //     hintText: "请输入验证码",
                  //     prefixIcon:
                  //         Icon(Icons.lock, color: ColorConfig.ThemeColor),
                  //     suffixIcon: TextButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         '获取验证码',
                  //         style: TextStyle(color: ColorConfig.ThemeColor),
                  //       ),
                  //     ),
                  //     fillColor: ColorConfig.ThemeColor,
                  //     labelStyle: TextStyle(color: ColorConfig.ThemeColor),
                  //     focusedBorder: UnderlineInputBorder(
                  //       //选中时下边框颜色
                  //       borderSide: BorderSide(color: ColorConfig.ThemeColor),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    width: 280,
                    height: 45.0,
                    child: new ElevatedButton(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        //设置按下时的背景颜色
                        if (states.contains(MaterialState.pressed)) {
                          return ColorConfig.ThemeOtherColor;
                        }
                        //默认不使用背景颜色
                        return ColorConfig.ThemeColor;
                      })),
                      child: Text("登录", style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        subLoging();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget register() {
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18),
      child: Column(
        children: [
          new Form(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "请输入用户名",
                    prefixIcon: Icon(
                      Icons.person,
                      color: ColorConfig.ThemeColor,
                    ),
                    fillColor: ColorConfig.ThemeColor,
                    labelStyle: TextStyle(color: ColorConfig.ThemeColor),
                    focusedBorder: UnderlineInputBorder(
                      //选中时下边框颜色
                      borderSide: BorderSide(color: ColorConfig.ThemeColor),
                    ),
                  ),
                  onChanged: (str) => {
                    setState(() {
                      this.regName = str;
                    })
                  },
                ),
                new TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "手机号",
                    hintText: "请输入手机号",
                    prefixIcon: Icon(
                      Icons.stay_current_portrait,
                      color: ColorConfig.ThemeColor,
                    ),
                    fillColor: ColorConfig.ThemeColor,
                    labelStyle: TextStyle(color: ColorConfig.ThemeColor),
                    focusedBorder: UnderlineInputBorder(
                      //选中时下边框颜色
                      borderSide: BorderSide(color: ColorConfig.ThemeColor),
                    ),
                  ),
                  onChanged: (str) => {
                    setState(() {
                      this.regPhpne = str;
                    })
                  },
                ),
                new TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "请输入密码",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: ColorConfig.ThemeColor,
                    ),
                    fillColor: ColorConfig.ThemeColor,
                    labelStyle: TextStyle(color: ColorConfig.ThemeColor),
                    focusedBorder: UnderlineInputBorder(
                      //选中时下边框颜色
                      borderSide: BorderSide(color: ColorConfig.ThemeColor),
                    ),
                  ),
                  onChanged: (str) => {
                    setState(() {
                      this.regPass = str;
                    })
                  },
                ),
                // new TextFormField(
                //   decoration: InputDecoration(
                //     labelText: "验证码",
                //     hintText: "请输入验证码",
                //     prefixIcon: Icon(Icons.lock, color: ColorConfig.ThemeColor),
                //     suffixIcon: TextButton(
                //       onPressed: () {},
                //       child: Text(
                //         '获取验证码',
                //         style: TextStyle(color: ColorConfig.ThemeColor),
                //       ),
                //     ),
                //     fillColor: ColorConfig.ThemeColor,
                //     labelStyle: TextStyle(color: ColorConfig.ThemeColor),
                //     focusedBorder: UnderlineInputBorder(
                //       //选中时下边框颜色
                //       borderSide: BorderSide(color: ColorConfig.ThemeColor),
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: 280,
                  height: 45.0,
                  child: new ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      //设置按下时的背景颜色
                      if (states.contains(MaterialState.pressed)) {
                        return ColorConfig.ThemeOtherColor;
                      }
                      //默认不使用背景颜色
                      return ColorConfig.ThemeColor;
                    })),
                    child: Text("注册", style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      subReg();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  subLoging() async {
    LoginData res = await UserService.Login(
      {
        'user_phone': this.loginPhpne,
        'sms_code': this.logingPass,
      },
    );
    if (res != null) {
      BotToast.showText(text: "登录成功");
      await getUserInfo(res.userInfo.userId);
      // 这信息只会更新一次，所以调用UserInfo保证每次都更新
      await SPreferences()
          .setString('userInfo', convert.jsonEncode(res.userInfo));
      await SPreferences().setString('token', res.userToken);
      await SPreferences().setBool("isLogin", true);
      Modular.to.pushReplacementNamed('/index');
    }
    // Navigator.of(context).pushNamed("/index");
  }

  subReg() async {
    RegData res = await UserService.Reg({
      "user_nickname": this.regName,
      "user_phone": this.regPhpne,
      "sms_code": this.regPass
    });
    BotToast.showText(text: "注册成功请登录");
    this.setState(() {
      this.loginPhpne = this.regPhpne;
      this.regName = '';
      this.regPhpne = '';
      this.regPass = '';
      tabController.animateTo(0);
    });
  }

  getUserInfo(int userId) async {
    UserInfoPersonalEntityData res =
        await UserService.UserInfo({"user_id": userId});
    await SPreferences().setString('onUserInfo', convert.jsonEncode(res));
  }
}
