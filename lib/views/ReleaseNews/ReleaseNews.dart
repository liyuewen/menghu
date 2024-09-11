import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/event/_.dart';
import 'package:peach/service/PublicService.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/Screen.dart';
import 'package:peach/widget/Panel.dart';
import 'package:peach/widget/_.dart';

/*
 * 发布动态
 */
class ReleaseNews extends StatefulWidget {
  @override
  _ReleaseNews createState() => _ReleaseNews();
}

class _ReleaseNews extends State<ReleaseNews>
    with SingleTickerProviderStateMixin {
  List<ImagePickerEntity> imgList = [];
  List<String> imageUrl = [];

  // tag标签
  TextEditingController introduce = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConfig.WhiteBackColor,
        // brightness: Brightness.dark,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorConfig.BlackBackColor,
          ),
        ),
        actions: [
          Container(
            width: Screen.setWidth(60),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            margin: EdgeInsets.only(right: 10),
            child: RaisedButton(
              color: ColorConfig.ThemeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '发布',
                style: TextStyle(color: ColorConfig.WhiteBackColor),
              ),
              onPressed: () {
                dynamicPush();
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: Screen.height(context),
        child: Panel(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: ListView(
              children: [
                Container(
                  height: Screen.setHeight(200),
                  child: TextField(
                    maxLines: 8,
                    controller: introduce,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: '这一刻的想法',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyle(fontSize: 14),
                    maxLength: 255,
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     "10/255",
                //     style: TextStyle(fontSize: 14, color: ColorConfig.TextColor),
                //   ),
                // ),
                Container(
                  height: Screen.setWidth(380),
                  margin: EdgeInsets.only(top: 10),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    children: [
                      ...imgList.asMap().keys.map((e) => imgView(e)).toList(),
                      imgList.length < 9
                          ? ImagePickerWidget(
                              child: Container(
                                height: Screen.setWidth(100),
                                width: Screen.setWidth(100),
                                decoration: new BoxDecoration(
                                  border: new Border.all(
                                      color: ColorConfig.TextColor, width: 0.5),
                                  borderRadius:
                                      new BorderRadius.circular((2.0)),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: ColorConfig.TextColor,
                                ),
                              ),
                              onChange: (ImagePickerEntity pickedFile) {
                                getImage(pickedFile);
                              },
                            )
                          : Container(
                              height: 0,
                              width: 0,
                            )
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

  Widget imgView(int e) {
    return Stack(
      children: [
        Container(
          height: Screen.setWidth(120),
          width: Screen.setWidth(120),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular((2.0)),
          ),
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(10),
            child: Image.file(
              imgList[e].getPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: GestureDetector(
            onTap: () {
              delImage(e);
            },
            child: Container(
              decoration:
                  BoxDecoration(color: ColorConfig.TransparentBackground),
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.close,
                color: ColorConfig.WhiteBackColor,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /*
   * 展示图片
   */
  getImage(ImagePickerEntity pickedFile) async {
    setState(() {
      imgList = [...imgList, pickedFile];
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

  delImage(int index) {
    setState(() {
      imgList.removeAt(index);
      imageUrl.removeAt(index);
    });
  }

  dynamicPush() async {
    Null res = await DynamicService.dynamicPush(
        {"dynamic_introduce": introduce.text, "dynamic_imgs": imageUrl});
    Config.eventBus.fire(ClassEditEvent(true));
    Navigator.of(context).pop();
  }
}
