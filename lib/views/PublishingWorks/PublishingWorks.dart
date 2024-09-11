import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:group_button/group_button.dart';
import 'package:peach/R.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/service/OpusService.dart';
import 'package:peach/service/PublicService.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/views/ImageView/ImageView.dart';
import 'package:peach/widget/_.dart';

/*
 * 发布作品
 */
class PublishingWorks extends StatefulWidget {
  @override
  _PublishingWorks createState() => _PublishingWorks();
}

class _PublishingWorks extends State<PublishingWorks>
    with SingleTickerProviderStateMixin {
  var count = 1;

  List<ImagePickerEntity> imageList = [];

  List<String> imageUrl = [];

  List<String> tagList = [];

  //标题
  TextEditingController titleText = TextEditingController();

  //介绍
  TextEditingController introduceText = TextEditingController();

  // tag标签
  TextEditingController tagText = TextEditingController();
  bool isTag = false;

  // 公开范围
  List<String> jurisdiction = [
    "所有人",
    "好友",
    "不公开",
  ];
  // 公开范围单选框
  int _jurisdiction = 0;

  // 作品类型列表
  int _original = 0;

  // 定时发布时间
  String _opusTime = "";

  //是否定时发布
  var _checkValue = false;

  bool syncDynamic = false;

  @override
  void initState() {
    super.initState();
    tagText.addListener(_onTagTextChange);
  }

  @override
  void dispose() {
    tagText.removeListener(_onTagTextChange);
    BotToast.closeAllLoading();
    super.dispose();
  }

  _onTagTextChange() {
    if (tagText.text.length > 0) {
      setState(() {
        isTag = true;
      });
      return;
    }
    setState(() {
      isTag = false;
    });
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
        appBar: AppBar(
          backgroundColor: ColorConfig.ThemeColor,
          centerTitle: true,
          title: Text("作品发布"),
        ),
        body: Container(
          height: Screen.height(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: Screen.width(context),
                  height: 200,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: new Swiper(
                    loop: false,
                    itemBuilder: (BuildContext context, int index) {
                      if (index + 1 == count) {
                        return ImagePickerWidget(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConfig.LineColor,
                                border: new Border.all(
                                  color: Color(0xFFFF0000),
                                  width: 0.5,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  R.libStaticAddTo,
                                  fit: BoxFit.fill,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            onChange: (ImagePickerEntity pickedFile) {
                              getImage(pickedFile);
                            });
                      } else {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              new FadeRoute(
                                page: PhotoViewGalleryScreen(
                                  images: imageList,
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.file(
                                imageList[index]?.getPath,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    itemCount: count,
                    viewportFraction: 0.6,
                    scale: 0.9,
                  ),
                ),
                Divider(),
                Panel(
                  child: Column(
                    children: [
                      titleConten(
                        "标题",
                        "",
                        TextField(
                          controller: titleText,
                          maxLength: 10,
                          decoration: InputDecoration(
                            hintText: "输入标题",
                            isDense: true,
                            labelStyle: TextStyle(
                              color: Colors.red,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              //选中时下边框颜色
                              borderSide: BorderSide(
                                color: ColorConfig.ThemeColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      titleConten(
                        "说明",
                        "",
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          controller: introduceText,
                          maxLength: 2000,
                          decoration: InputDecoration(
                            hintText: "输入说明",
                            isDense: true,
                            labelStyle: TextStyle(
                              color: Colors.red,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              //选中时下边框颜色
                              borderSide: BorderSide(
                                color: ColorConfig.ThemeColor,
                              ),
                            ),
                          ),
                          onChanged: (str) {
                            print(str);
                          },
                        ),
                      ),
                      titleConten(
                        "标签",
                        "",
                        Column(
                          children: [
                            label(),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    controller: tagText,
                                    decoration: InputDecoration(
                                      hintText: "输入标签",
                                      isDense: true,
                                      labelStyle: TextStyle(
                                        color: Colors.red,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        //选中时下边框颜色
                                        borderSide: BorderSide(
                                          color: ColorConfig.ThemeColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                isTag
                                    ? IconButton(
                                        icon: Icon(Icons.add),
                                        iconSize: 30,
                                        color: ColorConfig.ThemeColor,
                                        onPressed: () {
                                          setState(() {
                                            tagList.add(tagText.text);
                                            tagText.text = "";
                                          });
                                        },
                                      )
                                    : IconButton(
                                        icon: Icon(Icons.add),
                                        iconSize: 30,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        color: ColorConfig.ThemeOtherColor,
                                        onPressed: () {},
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                      titleConten(
                        "公开范围",
                        "",
                        GroupButton(
                          isRadio: true,
                          spacing: 10,
                          selectedColor: ColorConfig.ThemeColor,
                          onSelected: (index, isSelected) =>
                              _jurisdiction = index,
                          buttons: jurisdiction,
                        ),
                      ),
                      titleConten(
                        "作品类型",
                        "",
                        GroupButton(
                          isRadio: true,
                          spacing: 10,
                          selectedColor: ColorConfig.ThemeColor,
                          onSelected: (index, isSelected) => _original = index,
                          buttons: [
                            "原创作品",
                            "其他",
                          ],
                        ),
                      ),
                      titleConten(
                        "同步到动态",
                        "",
                        GroupButton(
                          isRadio: true,
                          spacing: 10,
                          selectedColor: ColorConfig.ThemeColor,
                          onSelected: (index, isSelected) =>
                              {syncDynamic = index == 0 ? true : false},
                          buttons: [
                            "同步",
                            "不同步",
                          ],
                        ),
                      ),
                      titleConten(
                        "定时发布",
                        "",
                        Container(
                          // constraints: BoxConstraints(
                          //   maxHeight: 300,
                          //   maxWidth: 200,
                          // ),
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: ColorConfig.ThemeColor,
                                value: _checkValue,
                                onChanged: (value) {
                                  setState(() {
                                    _checkValue = value;
                                  });
                                },
                              ),
                              Text("指定发布时间"),
                              _checkValue
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        onPressed: () {
                                          DatePicker.showDateTimePicker(
                                            context,
                                            showTitleActions: true,
                                            onConfirm: (date) {
                                              setState(
                                                () {
                                                  _opusTime =
                                                      Tool.dateAndTimeToString(
                                                    date.millisecondsSinceEpoch,
                                                    formart: {
                                                      "y-m": "/",
                                                      "m-d": "/",
                                                      "h-m": ":",
                                                      "m-s": ":"
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.zh,
                                          );
                                        },
                                        child: Text(
                                          _opusTime.length > 0
                                              ? _opusTime
                                              : '请选择时间',
                                          style: TextStyle(
                                              color: ColorConfig.ThemeColor),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "以下作品禁止发布。请在发布之前进行确认。",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "1.他人制作的作品，发售中的商品图像，第三方持有权利的图像、游戏、视频作品中的角色，包含截图画面的作品。",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "2.挪用以上画面，从最初开始就完全不是自己创作的作品。",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "3.作品以外的照片画面。",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "违反作品投稿利用规则的用户，将会被停止发布作品公开，停止账号使用。",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text.rich(
                          TextSpan(
                            text: '使用条款',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('onTap');
                              },
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text.rich(
                          TextSpan(
                            text: '凡违反',
                            style: TextStyle(
                                fontSize: 11, color: Color(0xFF999999)),
                            children: [
                              TextSpan(
                                text: '使用条款',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('onTap');
                                  },
                              ),
                              TextSpan(text: "和"),
                              TextSpan(
                                text: '用户须知',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('onTap');
                                  },
                              ),
                              TextSpan(text: "的作品将予以删除"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(top: 10),
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
                          child: Text("发布", style: TextStyle(fontSize: 20)),
                          onPressed: () {
                            opusPushOpus();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleConten(String title, String rightText, Widget child) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: ColorConfig.ThemeColor,
              ),
            ),
            Text(
              rightText,
              style: TextStyle(color: ColorConfig.ThemeColor, fontSize: 14),
            ),
          ],
        ),
        subtitle: Builder(
          builder: (context) {
            return Container(
              width: Screen.width(context),
              child: child,
            );
          },
        ),
      ),
    );
  }

  Widget label() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 5,
        runSpacing: 1,
        children: List.generate(
          tagList.length,
          (index) {
            return MediaQuery.removePadding(
              removeTop: true,
              removeBottom: true,
              context: context,
              child: RawChip(
                label: Text(tagList[index]),
                deleteIcon: Icon(
                  Icons.close,
                  size: 16,
                ),
                deleteIconColor: Colors.red,
                deleteButtonTooltipMessage: '删除',
                onDeleted: () {
                  setState(() {
                    tagList.remove(tagList[index]);
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  getImage(ImagePickerEntity pickedFile) async {
    setState(() {
      imageList = [...imageList, pickedFile];
      count = imageList.length + 1;
    });
    toolUploadFile(pickedFile.getPath);
  }

  toolUploadFile(File file) async {
    BotToast.showLoading();
    String path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formdata = FormData.fromMap(
        {"file": await MultipartFile.fromFile(path, filename: name)});
    ToolUploadFileEntityData res = await PublicService.toolUploadFile(formdata);
    imageUrl.add(res.imgUrl);
    BotToast.closeAllLoading();
  }

  opusPushOpus() async {
    if (imageUrl.length <= 0) {
      return BotToast.showText(text: "请上传作品");
    }
    if (titleText.text == "") {
      return BotToast.showText(text: "请输入作品标题");
    }
    if (tagList.length <= 0) {
      return BotToast.showText(text: "请填写标签");
    }
    Null res = await OpusService.opusPushOpus({
      "opus_title": titleText.text,
      "opus_introduce": introduceText.text,
      "opus_tags": tagList,
      "opus_imgs": imageUrl,
      "opus_jurisdiction": _jurisdiction + 1,
      "opus_original": _original + 1,
      "opus_time": _checkValue ? _opusTime : "",
      "opus_syncDynamic": syncDynamic
    });
    BotToast.showText(text: "发布成功");
    Navigator.of(context).pop();
  }
}
