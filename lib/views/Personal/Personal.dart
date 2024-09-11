import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/views/BlankPage.dart';
import 'package:peach/views/Dynamic/DynamicItem.dart';
import 'package:peach/widget/Empty.dart';
import 'package:peach/widget/_.dart';
import 'dart:math' as math;

/*
 * 个人空间
 */
class Personal extends StatefulWidget {
  final int userId;

  const Personal({this.userId});

  @override
  _Personal createState() => _Personal(this.userId);
}

class _Personal extends State<Personal> with SingleTickerProviderStateMixin {
  final int userId;

  ScrollController nestedScrollViewController;

  List<String> _tabValues = [
    '动态',
    '投稿',
    '收藏',
  ];
  TabController _tabController;

  double textHeight = 20;

  List<PageEntity> page = [
    PageEntity(),
    PageEntity(),
    PageEntity(),
  ];

  List<DynamicPersonalDynamicEntity> dynamicList = [];

  List<CollectionOpusListEntityResult> collectionOpusList = [];

  List<OpusListEntityResult> opusList = [];

  UserInfoPersonalEntityData userInfo;

  _Personal(this.userId);

  bool loading = true;

  EasyRefreshController _easyRefreshController;

  UserInfo _userInfo =
      UserInfo.fromJson(jsonDecode(SPreferences().getString("userInfo")));

  bool isCheckUser = false;

  @override
  void initState() {
    ///初始化，这个函数在生命周期中只调用一次
    super.initState();
    nestedScrollViewController = ScrollController();
    _easyRefreshController = EasyRefreshController();
    _tabController = TabController(length: _tabValues.length, vsync: this);
    future();

    nestedScrollViewController.addListener(() {
      if (nestedScrollViewController.position.pixels ==
          nestedScrollViewController.position.maxScrollExtent) {
        rollingToTheBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Loading();
    return Scaffold(
      body: NestedScrollView(
        controller: nestedScrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: Screen.setHeight(210) + textHeight,
              // collapsedHeight: Screen.setHeight(20) + Config.top,
              backgroundColor: ColorConfig.ThemeColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: ColorConfig.WhiteBackColor,
                  child: Column(
                    children: [
                      Container(
                        height: Screen.setHeight(90),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://dss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1770575461,2828994027&fm=26&gp=0.jpg"),
                          ),
                        ),
                      ),
                      Container(
                        height: Screen.setHeight(155),
                        child: Panel(
                          child: PersonalpTitle(
                            headImgHeight: 80,
                            isEditing: true,
                            textHeight: textHeight,
                            isOpenFollow: _userInfo.userId != userId,
                            isFollow: isCheckUser,
                            isText: textHeight > 20 ? true : false,
                            imgHead: userInfo.userHeadImg,
                            nickname: userInfo.userNickname,
                            autograph: userInfo.userAutograph,
                            fansNums: userInfo.fansNums,
                            satisfiedNums: userInfo.satisfiedNums,
                            followNums: userInfo.followNums,
                            userId: userInfo.userId,
                            onExpand: (height) {
                              setState(
                                () {
                                  textHeight = height;
                                },
                              );
                            },
                            opusFollowUser: () {
                              opusFollowUser(userId);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: CircleTransparentIcon(
                    icon: Icon(
                      Icons.search,
                      size: 18,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: CircleTransparentIcon(
                    icon: Transform.rotate(
                      //旋转90度
                      angle: math.pi / 2,
                      child: Icon(Icons.more_horiz),
                    ),
                  ),
                ),
              ],
            ),
            SliverPersistentHeader(
              delegate: _SliverTabBarDelegate(
                Container(
                  child: CustomTabBar(
                    tabController: _tabController,
                    tabValues: _tabValues,
                  ),
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: Container(
          height: Screen.height(context) - Screen.setHeight(400) - Config.top,
          child: TabBarView(
            controller: _tabController,
            children: [
              dynamicView(),
              contributionList(),
              _collectionList(),
            ],
          ),
        ),
      ),
    );
  }

  // 动态列表
  Widget dynamicView() {
    return Empty(
      isShow: dynamicList.length <= 0,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView(
          children: [
            ...dynamicList
                .asMap()
                .keys
                .map(
                  (e) => DynamicItem(
                    dynamicData: dynamicList[0],
                  ),
                )
                .toList(),
            page[0].isLoad ? loadingComplete() : null
          ],
        ),
      ),
    );
  }

  // 投稿列表
  Widget contributionList() {
    return Empty(
      isShow: opusList.length <= 0,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          children: [
            ...opusList
                .asMap()
                .keys
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed("/worksInfo/${opusList[e].opusId}");
                    },
                    child: Container(
                      height: Screen.width(context) / 2,
                      width: Screen.width(context) / 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            opusList[e].opusImg,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  // 收藏列表
  Widget _collectionList() {
    return Empty(
      isShow: collectionOpusList.length <= 0,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          children: [
            ...collectionOpusList
                .asMap()
                .keys
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed(
                          "/worksInfo/${collectionOpusList[e].opusId}");
                    },
                    child: Container(
                      height: Screen.width(context) / 2,
                      width: Screen.width(context) / 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            collectionOpusList[e].opusImg,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  // 加载完成
  loadingComplete() {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Text(
        "再这么找也没有啦",
        style: TextStyle(
          color: ColorConfig.TextColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  future() async {
    await dynamicPersonalDynamic();
    await getUserInfo();
    await getCollectionOpusList();
    await getOpusList();
    await isCheckUserIsFollow(userId);
    setState(() {
      loading = false;
    });
  }

  // 滚动触底时触发
  rollingToTheBottom() async {
    int index = _tabController.index;
    if (index == 0) {
      if (page[0].isLoad) return;
      page[0].page++;
      dynamicPersonalDynamic();
    } else if (index == 2) {
      if (page[2].isLoad) return;
      page[2].page++;
      getCollectionOpusList();
    }
  }

  // 动态列表
  dynamicPersonalDynamic() async {
    print(userId);
    DynamicPersonalDynamicEntityData res =
        await DynamicService.dynamicPersonalDynamic(
      {
        "page": page[0].page,
        "count": page[0].count,
        "userid": userId,
      },
    );
    if (res == null) return;
    if (res.result.length < page[0].count) {
      page[0].isLoad = true;
    }
    setState(() {
      dynamicList = [...dynamicList, ...res.result];
    });
  }

  // 个人信息
  getUserInfo() async {
    UserInfoPersonalEntityData res = await UserService.UserInfo({
      'user_id': userId,
    });
    setState(() {
      userInfo = res;
    });
  }

  // 设置关注
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

  isCheckUserIsFollow(int id) async {
    bool res = await OpusService.isCheckUserIsFollow({
      "user_to_id": id,
    });
    isCheckUser = res;
  }

  // 收藏列表
  getCollectionOpusList() async {
    CollectionOpusListEntityData res = await OpusService.collectionOpusList({
      'userid': userId,
      "page": page[2].page,
      "count": page[2].count,
    });
    if (res == null) return;
    if (res.result.length < page[2].count) {
      page[2].isLoad = true;
    }
    setState(() {
      collectionOpusList = res.result;
    });
  }

  getOpusList() async {
    OpusListEntityData res = await OpusService.getOpusList({
      'userid': userId,
      "page": page[1].page,
      "count": page[1].count,
    });
    if (res == null) return;
    if (res.result.length < page[1].count) {
      page[1].isLoad = true;
    }
    setState(() {
      opusList = res.result;
    });
  }
}

class CustomTabBar extends StatefulWidget {
  final TabController tabController;
  final List<String> tabValues;

  CustomTabBar({Key key, this.tabController, this.tabValues}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(30),
      child: Container(
        width: Screen.width(context),
        height: Screen.setHeight(40),
        decoration: BoxDecoration(
          color: ColorConfig.WhiteBackColor,
          border: Border(
            bottom: BorderSide(color: ColorConfig.LineColor, width: 1),
          ),
        ),
        child: TabBar(
          unselectedLabelColor: ColorConfig.TextColor,
          labelColor: ColorConfig.ThemeColor,
          indicatorColor: ColorConfig.ThemeColor,
          indicatorPadding: EdgeInsets.only(left: 30, right: 30),
          controller: widget.tabController,
          tabs: widget.tabValues
              .asMap()
              .keys
              .map(
                (e) => Tab(
                  child: Text(
                    widget.tabValues[e],
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final widget;

  _SliverTabBarDelegate(this.widget);

  @override
  double get minExtent => 40.0;

  @override
  double get maxExtent => 40.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
