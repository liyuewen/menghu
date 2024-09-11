import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/CommenListEntity.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/event/_.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/views/ImageView/ImageView.dart';
import 'package:peach/widget/Empty.dart';
import 'package:peach/widget/InputWidget/default_extra_item.dart';
import 'package:peach/widget/InputWidget/input_widget.dart';
import 'package:peach/widget/_.dart';
import 'dart:convert';
import 'dart:convert' as convert;

import 'EditWorkLabel.dart';

/*
 * 个人中心左边弹出层
 */
class WorksInfo extends StatefulWidget {
  final int opusId;

  const WorksInfo({this.opusId});

  @override
  _WorksInfo createState() => _WorksInfo(this.opusId);
}

class _WorksInfo extends State<WorksInfo> with SingleTickerProviderStateMixin {
  final int opusId;

  TextEditingController ctl = TextEditingController();
  EasyRefreshController _easyRefreshController;

  // 详情数据
  OpusOpusInfoEntityData infoData;

  // 回复框的节点信息
  FocusNode focusNode = FocusNode();

  // 当前用户是否被我关注过
  bool isCheckUser;

  // 当前用户是否被点赞
  bool isUpvote;

  // 当前用户是否点赞
  bool isCollectionOpus;

  UserInfo _userInfo =
      UserInfo.fromJson(jsonDecode(SPreferences().getString("userInfo")));

  int _currentPageIndex = 0;

  /*
   * 评论如果是艾特某人 
   */
  String hintText = "";

  /*
   *  编辑tag
   */
  bool edit = false;

  int commentReplyId = 0;

  PageEntity page = PageEntity();

  CommenListEntityData commenList;

  // 编辑标签的列表数据
  List<OpusTagEntityData> tagList = [];

  // 当前标签状态
  bool switchValue = false;

  bool loading = true;

  _WorksInfo(this.opusId);

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    ctl.addListener(onValueChange);
    SPreferences.init();
    Config.eventBus.on<ClassInputEditEvent>().listen((event) async {
      if (event.update) {
        await getOpusOpusInfo();
        setState(() {});
      }
    });
    future();
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
    print(commenList == null);
    if (loading) return Loading();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        bottomNavigationBar:
            Padding(padding: MediaQuery.of(context).viewInsets),
        appBar: AppBar(
          title: Text('作品详情'),
          toolbarHeight: Screen.setHeight(45),
          centerTitle: true,
          backgroundColor: ColorConfig.ThemeColor,
        ),
        body: Container(
          height: Screen.height(context) - Screen.setHeight(45) - Config.top,
          margin: EdgeInsets.only(bottom: 100),
          child: easyRefresh(
            ListView(
              children: [
                ...infoData.opusImgs
                    .asMap()
                    .keys
                    .map(
                      (e) => opusImgsView(e),
                    )
                    .toList(),
                ListTile(
                  title: Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: Text(
                      infoData.opusTitle,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        infoData.opusIntroduce,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TopicView(
                              tag: infoData.tags,
                              edit: isEdit(),
                              onTap: () {
                                editDialog();
                              }),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          width: Screen.width(context) / 1.5,
                          child: WorkDataView(
                            isUpvote: isUpvote,
                            isCollectionOpus: isCollectionOpus,
                            mainAxisAlignment: MainAxisAlignment.start,
                            infoData: infoData,
                            onUpvote: () {
                              opusUpvoteOpus(infoData.opusId);
                            },
                            onOpusCollectionOpus: () {
                              opusCollectionOpus(infoData.opusId);
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            infoData.opusTime,
                            style: TextStyle(
                              color: ColorConfig.TextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () {
                    Modular.to
                        .pushNamed("/personal/${infoData.userInfo.userId}");
                  },
                  child: Panel(
                    child: Row(
                      children: [
                        Container(
                          height: Screen.setWidth(40),
                          width: Screen.setWidth(40),
                          margin: EdgeInsets.only(right: Screen.setWidth(10)),
                          child: ClipOval(
                            child: Image.network(
                              infoData.userInfo.userHeadImg,
                              width: Screen.setWidth(45),
                              height: Screen.setWidth(45),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            infoData.userInfo.userNickname,
                          ),
                        ),
                        _userInfo.userId != infoData.userId
                            ? FollowButton(
                                isCheck: isCheckUser,
                                onPressed: () {
                                  opusFollowUser(infoData.userId);
                                },
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
                infoData.newsOpus.length > 0
                    ? Panel(
                        child: Container(
                          height: Screen.setHeight(120),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Modular.to.pushNamed(
                                        "/worksInfo/${infoData?.newsOpus[index].opusId}");
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      infoData?.newsOpus[index].opusImg,
                                      width: Screen.setWidth(120),
                                      height: Screen.setWidth(50),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              itemCount: infoData.newsOpus.length,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                infoData.newsOpus.length > 0
                    ? Container(
                        margin: EdgeInsets.only(bottom: 5),
                        alignment: Alignment.center,
                        child: Text(
                          "查看作品目录",
                          style: TextStyle(
                            color: ColorConfig.TextColor,
                          ),
                        ),
                      )
                    : Container(),
                Divider(),
                commenList != null
                    ? CommentList(
                        comment: commenList.result,
                        reply: (String userNickname, int id) {
                          hintText = userNickname;
                          commentReplyId = id;
                          Config.eventBus
                              .fire(ClasshHntTextEvent("@${userNickname}"));
                          FocusScope.of(context).requestFocus(focusNode);
                        },
                      )
                    : Empty(height: 300, isShow: true),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          height: Screen.setHeight(80),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: ColorConfig.LineColor, width: 1),
            ),
          ),
          child: InputWidget(
            controller: ctl,
            extraWidget: DefaultExtraWidget(),
            onSend: (value) {
              commentAdd(value);
            },
            onFocusNode: (FocusNode node) {
              this.focusNode = node;
            },
          ),
        ),
      ),
    );
  }

  Widget opusImgsView(int e) {
    List<ImagePickerEntity> arr = infoData.opusImgs
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
        width: Screen.width(context),
        height: processingImage(
          infoData?.opusImgs[e].imgHeight,
          infoData?.opusImgs[e].imgWidth,
        ),
        // decoration: new BoxDecoration(
        //   image: new DecorationImage(
        //     fit: BoxFit.cover,
        //     image: NetworkImage(infoData?.opusImgs[e].imgUrl),
        //   ),
        // ),
        child: CachedNetworkImage(
          imageUrl: infoData?.opusImgs[e].imgUrl,
          placeholder: (context, url) => new Container(
            child: new Center(
              child: new CircularProgressIndicator(),
            ),
            width: 160.0,
            height: 90.0,
          ),
          errorWidget: (context, url, error) => new Icon(Icons.error),
          fit: BoxFit.cover,
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
        page.page = 1;
        page.isLoad = false;
        await getCommentList();
        setState(() {});
        _easyRefreshController.finishRefresh(success: true);
      },
      onLoad: () async {
        if (page.isLoad) {
          await getCommentList();
        } else {
          page.page += 1;
          await getCommentList();
        }
        _easyRefreshController.finishLoad();
      },
    );
  }

  future() async {
    await getOpusOpusInfo();
    await getCommentList();
    setState(() {
      loading = false;
    });
  }

  /*
  * 获取作品详情
 */
  getOpusOpusInfo() async {
    print(opusId);
    OpusOpusInfoEntityData res = await OpusService.getOpusOpusInfo({
      "opus_id": opusId,
    });
    await isCheckUserIsFollow(res.userId);
    await opusCheckOpusIsUpvote(res.opusId);
    await opusCheckOpusIsCollection(res.opusId);
    infoData = res;
  }

  /*
   * 评论列表
   */
  getCommentList() async {
    CommenListEntityData res = await CommentService.getCommentList({
      "opus_id": opusId,
      "page": page.page,
      "count": page.count,
      "comment_type": 1
    });
    // print(_arguments.getId);
    if (res == null) return;
    if (res.result.length < page.count) {
      page.isLoad = true;
    }

    commenList = res;
  }

  commentAdd(String str) async {
    if (str.trim().length <= 0) {
      BotToast.showText(text: "回复内容不能为空");
      return;
    }
    Null res = await CommentService.commentAdd({
      "opus_id": infoData.opusId,
      "comment_content": str,
      "comment_to_username": hintText,
      "comment_reply_id": commentReplyId,
    });
    await getCommentList();
    hintText = "";
    commentReplyId = 0;
    Config.eventBus.fire(ClasshHntTextEvent("回复"));
    BotToast.showText(text: "发送成功");
    this.setState(() {});
  }

  isCheckUserIsFollow(int id) async {
    bool res = await OpusService.isCheckUserIsFollow({
      "user_to_id": id,
    });
    isCheckUser = res;
  }

  opusFollowUser(int id) async {
    Null res = await OpusService.opusFollowUser({
      "user_to_id": id,
    });
    if (isCheckUser) {
      BotToast.showText(text: "取消关注");
    } else {
      BotToast.showText(text: "关注成功");
    }
    await isCheckUserIsFollow(id);
    this.setState(() {});
  }

  opusCheckOpusIsUpvote(int id) async {
    bool res = await OpusService.opusCheckOpusIsUpvote({
      "opus_id": id,
    });
    isUpvote = res;
  }

  opusUpvoteOpus(int id) async {
    Null res = await OpusService.opusUpvoteOpus({
      "opus_id": id,
    });
    await getOpusOpusInfo();
    this.setState(() {});
    if (isUpvote) {
      BotToast.showText(text: "点赞成功");
    } else {
      BotToast.showText(text: "取消点赞");
    }
    // await opusCheckOpusIsUpvote(id);
  }

  // 检查作品是否被收藏
  opusCheckOpusIsCollection(int id) async {
    bool res = await OpusService.opusCheckOpusIsCollection({
      "opus_id": id,
    });
    isCollectionOpus = res;
  }

  opusCollectionOpus(int id) async {
    Null res = await OpusService.opusCollectionOpus({
      "opus_id": id,
    });
    await getOpusOpusInfo();
    this.setState(() {});
    if (isCollectionOpus) {
      BotToast.showText(text: "收藏成功");
    } else {
      BotToast.showText(text: "取消收藏");
    }
  }

  /*
   * 是否可修改标签，如果是当前作品发布者可以修改，如果开启修改则可以修改
   */
  isEdit() {
    var userInfo = convert.jsonDecode(SPreferences().getString("userInfo"));
    if (infoData.userId == userInfo["user_id"]) {
      return true;
    }
    return infoData.opusIsEdit == 1;
  }

  /*
   * 编辑当前的标签
   */
  editDialog() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return EditWorkLabel(
          opusId: infoData.opusId,
          isEdit: infoData.opusIsEdit,
        );
      },
    ).then((val) {
      print(val);
    });
  }

  /**
   * 处理图片宽高
   */
  processingImage(int height, int width) {
    double w = Screen.width(context) / width;
    double h = height * w;
    return h;
  }
}

enum Action { Ok, Cancel }
