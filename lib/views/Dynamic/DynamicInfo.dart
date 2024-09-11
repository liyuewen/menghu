import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/event/_.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/views/ImageView/ImageView.dart';
import 'package:peach/widget/Empty.dart';
import 'package:peach/widget/InputWidget/default_extra_item.dart';
import 'package:peach/widget/InputWidget/input_widget.dart';
import 'package:peach/widget/Line.dart';
import 'dart:math' as math;

import 'package:peach/widget/Panel.dart';
import 'package:peach/widget/_.dart';

/*
 * 动态
 */
class DynamicInfo extends StatefulWidget {
  final String dynamicId;

  const DynamicInfo({this.dynamicId});

  @override
  _DynamicInfo createState() => _DynamicInfo(this.dynamicId);
}

class _DynamicInfo extends State<DynamicInfo> {
  var hintText;

  final String dynamicId;

  FocusNode focusNode;

  List<CommenListEntity> commenList = [];

  TextEditingController ctl = TextEditingController();

  EasyRefreshController _easyRefreshController;

  DynamicInfoEntityData data;

  PageEntity page = PageEntity();

  bool loading = true;

  int commentReplyId;

  _DynamicInfo(this.dynamicId);

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    ctl.addListener(onValueChange);
    this.future();
  }

  void dispose() {
    ctl.removeListener(onValueChange);
    ctl.dispose();
    super.dispose();
  }

  void onValueChange() {
    print("${ctl.text} +++++++");
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Loading();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: Screen.setHeight(45),
          backgroundColor: ColorConfig.WhiteBackColor,
          elevation: 0,
          leading: Icon(
            Icons.arrow_back,
            color: ColorConfig.BlackBackColor,
          ),
          title: Align(
            alignment: Alignment.center,
            child: Text("详情",
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorConfig.TitleColor)),
          ),
        ),
        body: Container(
          height: Screen.height(context) - Screen.setHeight(45) - Config.top,
          margin: EdgeInsets.only(bottom: 100),
          child: easyRefresh(
            ListView(
              children: [
                Panel(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: ClipOval(
                          child: data?.userInfo?.userHeadImg != null
                              ? Image.network(
                                  data?.userInfo?.userHeadImg,
                                  width: Screen.setWidth(40),
                                  height: Screen.setWidth(40),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${data?.userInfo?.userNickname}"),
                              Text(
                                "${data?.dynamicTime}",
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text("置顶"),
                    ],
                  ),
                ),
                Panel(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${data?.dynamicIntroduce}",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Panel(
                  child: data != null
                      ? Container(
                          height: gridViewHeight(data.dynamicImgs.length),
                          child: GridView(
                            physics: new NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  gridCrossAxisCount(data.dynamicImgs.length),
                            ),
                            children: [
                              ...data.dynamicImgs
                                  .asMap()
                                  .keys
                                  .map((e) => _createGridViewItem(
                                      data.dynamicImgs[e].imgUrl, e))
                                  .toList()
                            ],
                          ),
                        )
                      : null,
                ),
                Line(),
                Panel(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "热门评论",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                commenList != null
                    ? CommentList(
                        comment: commenList,
                        reply: (String userNickname, int id) {
                          hintText = userNickname;
                          commentReplyId = id;
                          Config.eventBus
                              .fire(ClasshHntTextEvent("@${userNickname}"));
                          FocusScope.of(context).requestFocus(focusNode);
                        },
                      )
                    : Empty(),
              ],
            ),
          ),
        ),
        bottomSheet: InputWidget(
          controller: ctl,
          // hintText: hintText,
          extraWidget: DefaultExtraWidget(),
          onSend: (value) {
            // print("send text $value");
            commentAdd(value);
          },
          onFocusNode: (FocusNode node) {
            this.focusNode = node;
          },
        ),
      ),
    );
  }

  // 下拉刷新上啦加载
  Widget easyRefresh(Widget child) {
    return EasyRefresh(
      header: BezierCircleHeader(backgroundColor: ColorConfig.ThemeColor),
      footer: BezierBounceFooter(backgroundColor: ColorConfig.ThemeColor),
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      controller: _easyRefreshController,
      child: child,
      bottomBouncing: true,
      onRefresh: () async {
        commenList = [];
        page.page = 1;
        await this.getCommentList();
        _easyRefreshController.finishRefresh(success: true);
      },
      onLoad: () async {
        if (!page.isLoad) {
          page.page++;
          await this.getCommentList();
          _easyRefreshController.finishLoad();
        } else {
          new Future.delayed(Duration(seconds: 1), () {
            _easyRefreshController.finishLoad();
          });
        }
      },
    );
  }

  _createGridViewItem(String str, int e) {
    List<ImagePickerEntity> arr = data.dynamicImgs
        .map((e) => ImagePickerEntity(netWorkPath: e.imgUrl))
        .toList();
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          new FadeRoute(
            page: PhotoViewGalleryScreen(
              images: arr,
              index: e,
            ),
          ),
        );
      },
      child: Container(
        height: Screen.setHeight(80),
        child: str != null
            ? Image.network(
                str,
                width: Screen.setWidth(40),
                height: Screen.setWidth(40),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }

  gridViewHeight(int imgLength) {
    double height = Screen.width(context) - Screen.setHeight(20);
    if (imgLength == 1) {
      return height / 1.5 + 1;
    } else if (imgLength <= 3) {
      return height / 2 + 1;
    } else if (imgLength <= 6) {
      return height / 1.5 + 1;
    } else {
      return height + 1;
    }
  }

  gridCrossAxisCount(int imgLength) {
    if (imgLength == 1) {
      return 1;
    } else if (imgLength == 2) {
      return 2;
    } else {
      return 3;
    }
  }

  future() async {
    await dynamicInfo();
    await getCommentList();
    setState(() {
      loading = false;
    });
  }

  /*
   * 评论列表
   */
  getCommentList() async {
    CommenListEntityData res = await CommentService.getCommentList({
      "dynamic_id": dynamicId,
      "page": page.page,
      "count": page.count,
      "comment_type": 2,
    });
    if (res == null) return;
    if (page.count > res.result.length) {
      page.isLoad = true;
    }
    commenList = [...commenList, ...res.result];
  }

  /**
   * 获取当前详情信息
   */
  dynamicInfo() async {
    DynamicInfoEntityData res =
        await DynamicService.dynamicInfo({"dynamic_id": dynamicId});
    data = res;
  }

  commentAdd(String str) async {
    if (str.trim().length <= 0) {
      BotToast.showText(text: "回复内容不能为空");
      return;
    }
    print(commentReplyId);
    Null res = await CommentService.commentAdd({
      "dynamic_id": dynamicId,
      "comment_content": str,
      "comment_type": 2,
      "comment_reply_id": commentReplyId,
    });
    BotToast.showText(text: "发送成功");
    page.page = 1;
    page.isLoad = false;
    commenList = [];
    getCommentList();
  }
}
