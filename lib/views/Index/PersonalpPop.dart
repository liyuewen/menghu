import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/widget/PersonalpTitle.dart';

/*
 * 首页
 */
class PersonalpPop extends StatefulWidget {
  @override
  _PersonalpPop createState() => _PersonalpPop();
}

class _PersonalpPop extends State<PersonalpPop>
    with SingleTickerProviderStateMixin {
  UserInfoPersonalEntityData userInfo = UserInfoPersonalEntityData.fromJson(
      jsonDecode(SPreferences().getString("onUserInfo")));

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color: ColorConfig.WhiteBackColor,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        child: PersonalpTitle(
                            imgHead: userInfo.userHeadImg,
                            nickname: userInfo.userNickname,
                            autograph: userInfo.userAutograph,
                            fansNums: userInfo.fansNums,
                            satisfiedNums: userInfo.satisfiedNums,
                            followNums: userInfo.followNums,
                            userId: userInfo.userId),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed("/personal/${userInfo.userId}");
                        },
                        child: ListTile(
                          leading: Icon(Icons.grade),
                          title: Text('个人空间'),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/publishingWorks");
                        },
                        child: ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text('发布作品'),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('我要约稿'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('我要接稿'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('创作激励'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('投稿管理'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('我的收藏'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('联系客服'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [Icon(Icons.access_alarm), Text("设置")],
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [Icon(Icons.access_alarm), Text("设置")],
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [Icon(Icons.access_alarm), Text("设置")],
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
