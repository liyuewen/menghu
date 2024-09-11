import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/views/BlankPage.dart';
import 'package:peach/views/Dynamic/DynamicItem.dart';
import 'package:peach/widget/_.dart';
import 'dart:math' as math;

/*
 * 个人空间
 */
class Personal extends StatefulWidget {
  final String isLeading;

  const Personal({this.isLeading = '0'});

  @override
  _Personal createState() => _Personal(this.isLeading);
}

class _Personal extends State<Personal> with SingleTickerProviderStateMixin {
  final String isLeading;

  List<String> _tabValues = [
    '动态',
    '投稿',
    '收藏',
  ];
  TabController _tabController;

  double textHeight = 20;

  PageEntity page = PageEntity();

  List<DynamicPersonalDynamicEntity> dynamicList = [];

  UserInfo _userInfo =
      UserInfo.fromJson(jsonDecode(SPreferences().getString("userInfo")));

  _Personal(this.isLeading);

  bool loading = true;

  @override
  void initState() {
    ///初始化，这个函数在生命周期中只调用一次
    super.initState();
    _tabController = TabController(length: _tabValues.length, vsync: this);
    future();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Loading();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: Screen.setHeight(190) + textHeight,
              collapsedHeight: Screen.setHeight(20) + Config.top,
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
                        height: Screen.setHeight(140),
                        child: Panel(
                          child: PersonalpTitle(
                            headImgHeight: 80,
                            isEditing: true,
                            textHeight: textHeight,
                            isText: textHeight > 20 ? true : false,
                            onExpand: (height) {
                              setState(
                                () {
                                  textHeight = height;
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              leading: isLeading == '1'
                  ? null
                  : Container(
                      width: 1,
                      height: 1,
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
        body: TabBarView(
          controller: _tabController,
          children: [
            MediaQuery.removePadding(
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
                  Container(
                    height: 80,
                  )
                ],
              ),
            ),
            BlankPage(),
            _collectionList()
          ],
        ),
      ),
    );
  }

  // 推荐item样式
  Widget _collectionList() {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(
              //   "/worksInfo",
              //   arguments: WorksInfoProps(this.tabsResult[index][e].opusId),
              // );
            },
            child: Container(
              height: Screen.width(context) / 2,
              width: Screen.width(context) / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://upload.jianshu.io/users/upload_avatars/5685558/23e20d58-c5e1-4fd6-90d4-a3752cbe7d6a",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(
              //   "/worksInfo",
              //   arguments: WorksInfoProps(this.tabsResult[index][e].opusId),
              // );
            },
            child: Container(
              height: Screen.width(context) / 2,
              width: Screen.width(context) / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://upload.jianshu.io/users/upload_avatars/5685558/23e20d58-c5e1-4fd6-90d4-a3752cbe7d6a",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(
              //   "/worksInfo",
              //   arguments: WorksInfoProps(this.tabsResult[index][e].opusId),
              // );
            },
            child: Container(
              height: Screen.width(context) / 2,
              width: Screen.width(context) / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://upload.jianshu.io/users/upload_avatars/5685558/23e20d58-c5e1-4fd6-90d4-a3752cbe7d6a",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(
              //   "/worksInfo",
              //   arguments: WorksInfoProps(this.tabsResult[index][e].opusId),
              // );
            },
            child: Container(
              height: Screen.width(context) / 2,
              width: Screen.width(context) / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://upload.jianshu.io/users/upload_avatars/5685558/23e20d58-c5e1-4fd6-90d4-a3752cbe7d6a",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  future() async {
    await dynamicPersonalDynamic();
    setState(() {
      loading = false;
    });
  }

  dynamicPersonalDynamic() async {
    DynamicPersonalDynamicEntityData res =
        await DynamicService.dynamicPersonalDynamic(
      {
        "page": page.page,
        "count": page.count,
        "userid": _userInfo.userId,
      },
    );
    dynamicList = res.result;
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
