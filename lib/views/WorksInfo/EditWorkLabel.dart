import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/event/_.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/_.dart';
import 'dart:convert' as convert;

/*
 * 编辑作品标签
 */

//新的Stateful Widget 存放 Dialog Content
class EditWorkLabel extends StatefulWidget {
  final int opusId;
  final int isEdit;

  EditWorkLabel({this.opusId, this.isEdit});
  @override
  State<StatefulWidget> createState() =>
      _EditWorkLabel(opusId: this.opusId, isEdit: this.isEdit);
}

class _EditWorkLabel extends State<EditWorkLabel> {
  String text = "";

  final int opusId;

  final int isEdit;

  // 编辑标签的列表数据
  List<OpusTagEntityData> tag = [];

  // 当前标签状态
  bool switchValue = false;

  _EditWorkLabel({this.opusId, this.isEdit});

  @override
  void initState() {
    super.initState();
    tagOpusTag(this.opusId);
    switchValue = this.isEdit == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: ShapeDecoration(
            color: Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          margin: EdgeInsets.only(
              top: Screen.setHeight(100),
              bottom: Screen.setHeight(150),
              left: 20,
              right: 20),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text("编辑作品标签"),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("作品标签"),
                    // Text("${tag != null ? tag.length : 0}/10")
                  ],
                ),
              ),
              Container(
                height: Screen.setHeight(120),
                child: ListView(
                  children: tag != null
                      ? tag.map((e) {
                          return Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.tagsTitle),
                                GestureDetector(
                                  onTap: () {
                                    _openAlertDialog(e.tagsId);
                                  },
                                  child: Text(
                                    "删除",
                                    style: TextStyle(
                                      color: ColorConfig.ThemeColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList()
                      : [],
                ),
              ),
              Container(
                color: ColorConfig.AshPlacement,
                height: Screen.setHeight(35),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 5),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '请输入标签名',
                              hintStyle: TextStyle(color: Colors.grey),
                              hintMaxLines: 1,
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 11),
                            ),
                            onChanged: (value) => {text = value},
                          ),
                        ),
                      ),
                      Text("0/30")
                    ],
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    tagOpusInfoCreatedTags(text);
                  },
                  child: Text(
                    "确定",
                    style: TextStyle(
                      color: ColorConfig.ThemeColor,
                    ),
                  )),
              Row(
                children: [
                  Switch(
                    value: switchValue,
                    onChanged: (value) {
                      tagUpdateTagsEditStatus(value);
                    },
                  ),
                  Text("允许其他会员添加标签")
                ],
              ),
              Container(
                width: Screen.width(context),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        //设置按下时的背景颜色
                        if (states.contains(MaterialState.pressed)) {
                          return ColorConfig.ThemeOtherColor;
                        }
                        //默认不使用背景颜色
                        return ColorConfig.ThemeColor;
                      },
                    ),
                  ),
                  child: Text("关闭", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 获取标签列表
  tagOpusTag(int opusId) async {
    List<OpusTagEntityData> res =
        await TagService.tagOpusTag({"opus_id": opusId});
    setState(() {
      tag = res;
    });
  }

  // 新增标签
  tagOpusInfoCreatedTags(String title) async {
    if (title == null || title == '') {
      return BotToast.showText(text: "标签内容不能为空");
    }
    var userInfo = convert.jsonDecode(SPreferences().getString("userInfo"));
    Null res = await TagService.tagOpusInfoCreatedTags({
      "tags_title": title,
      "user_id": userInfo["user_id"],
      "opus_id": opusId
    });
    Navigator.pop(context);
    BotToast.showText(text: "新增标签成功");
    await tagOpusTag(opusId);
    Config.eventBus.fire(ClassInputEditEvent(true));
  }

  // 删除标签
  tagDeleteTag(int tagsId) async {
    await TagService.tagDeleteTag({"tags_id": tagsId});
    Navigator.pop(context);
    BotToast.showText(text: "删除标签成功");
    await tagOpusTag(opusId);
    Config.eventBus.fire(ClassInputEditEvent(true));
  }

  // 删除标签确认弹出层
  Future _openAlertDialog(int tagsId) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false, //// user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '提示',
            style: TextStyle(
              color: ColorConfig.ThemeColor,
            ),
          ),
          content: Text('是否删除?'),
          actions: <Widget>[
            TextButton(
              child: Text(
                '取消',
                style: TextStyle(
                  color: ColorConfig.ThemeColor,
                ),
              ),
              onPressed: () {
                Navigator.pop(context, Action.Cancel);
              },
            ),
            TextButton(
              child: Text(
                '确认',
                style: TextStyle(
                  color: ColorConfig.ThemeColor,
                ),
              ),
              onPressed: () {
                Navigator.pop(context, Action.Ok);
              },
            ),
          ],
        );
      },
    );

    switch (action) {
      case Action.Ok:
        tagDeleteTag(tagsId);
        break;
      case Action.Cancel:
        break;
      default:
    }
  }

  tagUpdateTagsEditStatus(bool value) async {
    Null res = await TagService.tagUpdateTagsEditStatus(
        {"opus_id": opusId, "edit_status": value ? 1 : 0});
    setState(() {
      switchValue = value;
    });
  }
}

enum Action { Ok, Cancel }
