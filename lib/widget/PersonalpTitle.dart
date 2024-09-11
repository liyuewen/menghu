import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/widget/TextLimitDisplay.dart';
import 'package:peach/widget/_.dart';

/*
 * 头像和粉丝内容等
 */
class PersonalpTitle extends StatelessWidget {
  final double headImgHeight;
  final bool isEditing;
  final bool isText;
  final Function onExpand;
  final double textHeight;
  // 是否是本人空间 true 是
  final bool isOpenFollow;
  // 是否已经关注 true 是
  final bool isFollow;
  final Function opusFollowUser;

  // 头像
  final String imgHead;
  final String nickname;
  final String autograph;
  final int fansNums;
  final int satisfiedNums;
  final int followNums;

  final int userId;

  PersonalpTitle({
    this.headImgHeight = 58,
    this.isEditing = false,
    this.onExpand,
    this.isText = false,
    this.textHeight = 20,
    this.imgHead = '',
    this.nickname = '',
    this.autograph = '',
    this.fansNums = 0,
    this.satisfiedNums = 0,
    this.followNums = 0,
    this.isOpenFollow = false,
    this.isFollow = false,
    this.opusFollowUser,
    this.userId = 0,
  });

  GlobalKey txtKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print(this.userId);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                margin: EdgeInsets.only(right: Screen.setWidth(40)),
                child: ClipOval(
                  child: Image.network(
                    imgHead,
                    width: Screen.setWidth(this.headImgHeight),
                    height: Screen.setWidth(this.headImgHeight),
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    width: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Modular.to.pushNamed("/fans/${userId}");
                          },
                          child: Column(
                            children: [
                              Text(fansNums.toString(),
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                "粉丝",
                                style: TextStyle(
                                  color: ColorConfig.TextColor,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Modular.to.pushNamed("/follow/${userId}");
                          },
                          child: Column(
                            children: [
                              Text(followNums.toString(),
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                "关注",
                                style: TextStyle(
                                  color: ColorConfig.TextColor,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(satisfiedNums.toString(),
                                style: TextStyle(fontSize: 16)),
                            Text(
                              "获赞",
                              style: TextStyle(
                                color: ColorConfig.TextColor,
                                fontSize: 14,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  this.isEditing
                      ? Container(
                          width: Screen.setWidth(240),
                          child: isOpenFollow
                              ? FollowButton(
                                  isCheck: isFollow,
                                  onPressed: () {
                                    opusFollowUser();
                                  })
                              : ElevatedButton(
                                  style: ButtonStyle(backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    //设置按下时的背景颜色
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return ColorConfig.ThemeOtherColor;
                                    }
                                    //默认不使用背景颜色
                                    return ColorConfig.ThemeColor;
                                  })),
                                  child: Text("编辑资料",
                                      style: TextStyle(fontSize: 20)),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed("/editMaterials");
                                  },
                                ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: Screen.setHeight(10)),
          height: Screen.setHeight(20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              nickname,
              style: TextStyle(
                color: ColorConfig.ThemeColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(top: Screen.setHeight(10)),
            height: textHeight,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: TextLimitDisplay(
                      key: txtKey,
                      text: autograph,
                      minLines: 1, // 收起状态下最大展示行数
                      maxLines: 6, // 展开后最大展示行数限制
                      isExpand: isText,
                      textStyle: TextStyle(
                        color: ColorConfig.ThemeColor,
                      ),
                      onExpand: () {
                        onExpand(20.00);
                      },
                      onShrink: () {
                        Timer.periodic(Duration(milliseconds: 100), (t) {
                          var keyContext = txtKey.currentContext;
                          if (keyContext != null) {
                            final txtBox =
                                keyContext.findRenderObject() as RenderBox;
                            onExpand(txtBox.size.height);
                            print(txtBox.size.height);
                          }
                          t.cancel();
                        });
                      },
                    ),
                  );
                },
                itemCount: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
