import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/entity/DynamicTabsDynamicEntity.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/widget/_.dart';
import 'dart:math' as math;

/*
 * 动态列表
 */
class DynamicItem extends StatefulWidget {
  final dynamic dynamicData;

  const DynamicItem({this.dynamicData});

  @override
  _DynamicItem createState() => _DynamicItem(this.dynamicData);
}

class _DynamicItem extends State<DynamicItem> {
  final dynamic dynamicData;

  _DynamicItem(this.dynamicData);

  @override
  Widget build(BuildContext context) {
    return item();
  }

  Widget item() {
    return Column(
      children: [
        Line(),
        Panel(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed(
                          "/personal/${dynamicData.userInfo.userId}");
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: ClipOval(
                        child: Image.network(
                          dynamicData.userInfo.userHeadImg,
                          width: Screen.setWidth(40),
                          height: Screen.setWidth(40),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dynamicData.userInfo.userNickname),
                            Text(
                              Tool.dateAndTimeToString(
                                Tool.timeToStamp(dynamicData.dynamicTime),
                                formart: {"y-m": "-", "m-d": "-", "h-m": ":"},
                              ),
                            ),
                          ],
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      itemShowDialog();
                    },
                    child: Transform.rotate(
                      //旋转90度
                      angle: math.pi / 2,
                      child: Icon(Icons.more_horiz),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (dynamicData.dynamicType == 1) {
                    Modular.to.pushNamed("/worksInfo/${dynamicData.opusId}");
                  } else {
                    Modular.to
                        .pushNamed("/dynamicInfo/${dynamicData.dynamicId}");
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    dynamicData.dynamicIntroduce,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              dynamicData.dynamicImg != ""
                  ? GestureDetector(
                      onTap: () {
                        if (dynamicData.dynamicType == 1) {
                          Modular.to
                              .pushNamed("/worksInfo/${dynamicData.opusId}");
                        } else {
                          Modular.to.pushNamed(
                              "/dynamicInfo/${dynamicData.dynamicId}");
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.centerLeft,
                        child: Image.network(
                          dynamicData.dynamicImg,
                          width: Screen.width(context),
                          height: Screen.setWidth(182),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.near_me,
                            size: 18,
                            color: ColorConfig.TextColor,
                          ),
                          Text(
                            dynamicData.dynamicShareCount.toString(),
                            style: TextStyle(
                              color: ColorConfig.TextColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble,
                            size: 16,
                            color: ColorConfig.TextColor,
                          ),
                          Text(
                            dynamicData.dynamicCommentCount.toString(),
                            style: TextStyle(
                              color: ColorConfig.TextColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 18,
                            color: ColorConfig.TextColor,
                          ),
                          Text(
                            dynamicData.dynamicSatisfiedCount.toString(),
                            style: TextStyle(
                              color: ColorConfig.TextColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  itemShowDialog() {
    RoutineShowDialog.itemShowDialog(context);
  }
}
