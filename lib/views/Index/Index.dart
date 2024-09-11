import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:peach/config/Index.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/widget/Empty.dart';
import 'package:peach/widget/_.dart';

/*
 * 首页
 */
class Index extends StatefulWidget {
  final Function clickHead;

  const Index({Key key, this.clickHead}) : super(key: key);
  @override
  _Index createState() => _Index(this.clickHead);
}

class _Index extends State<Index> with SingleTickerProviderStateMixin {
  final Function clickHead;

  _Index(this.clickHead);

  final List<String> _tabValues = ['推荐', '排行', '关注'];

  List<List<dynamic>> tabsResult = [[], [], []];

  int index = 0;

  List<PageEntity> pageList = [
    PageEntity(),
    PageEntity(),
    PageEntity(),
  ];

  PageController _controller;
  TabController _tabController;

  EasyRefreshController _easyRefreshController;

  BoxDecoration decoration = BoxDecoration(color: ColorConfig.WhiteBackColor);

  UserInfoPersonalEntityData userInfo = UserInfoPersonalEntityData.fromJson(
      jsonDecode(SPreferences().getString("onUserInfo")));

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _tabController = new TabController(length: _tabValues.length, vsync: this);
    _easyRefreshController = EasyRefreshController();
    getOpusRecommend();
    opusRanking();
    getFollow();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: leading(),
        toolbarHeight: Screen.setHeight(82),
        backgroundColor: ColorConfig.ThemeColor,
        title: title(),
        bottom: bottom(),
      ),
      body: Container(
        height: Screen.height(context) - Screen.setHeight(132) - Config.top,
        margin: EdgeInsets.only(top: 2, bottom: 2),
        child: PageView(
          controller: _controller,
          children: <Widget>[
            indexView(),
            rankingView(),
            userViewList(),
          ],
          onPageChanged: (e) => {
            this.setState(() {
              index = e;
            })
          },
        ),
      ),
    );
  }

  // 推荐item样式
  _createGridViewItem(int e) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed("/worksInfo/${this.tabsResult[0][e].opusId}");
      },
      child: Container(
        height: Screen.width(context) / 2,
        width: Screen.width(context) / 2,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage(this.tabsResult[0][e].opusImg),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: CachedNetworkImage(
          imageUrl: tabsResult[0][e].opusImg,
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

  Widget leading() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTapDown: (TapDownDetails tapDownDetails) {
          clickHead();
        },
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: ClipOval(
              child: Image.network(
                userInfo.userHeadImg,
                width: Screen.setWidth(38),
                height: Screen.setWidth(38),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Row(
      children: <Widget>[
        // indexSearch
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/indexSearch");
            },
            child: ExhibitionSearch(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Icon(Icons.person),
                  Text(
                    "好友",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  Icon(Icons.group),
                  Text(
                    "群聊",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bottom() {
    return PreferredSize(
      preferredSize: Size.fromHeight(10),
      child: Container(
        height: Screen.setHeight(38),
        width: Screen.width(context),
        decoration: BoxDecoration(color: ColorConfig.WhiteBackColor),
        child: Align(
          child: TabBar(
            tabs: _tabValues
                .asMap()
                .keys
                .map((e) => Tab(
                      child: Container(
                        decoration: index == e
                            ? BoxDecoration(
                                color: ColorConfig.ThemeColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                              )
                            : decoration,
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 6, bottom: 6),
                        child: Text(_tabValues[e],
                            style: TextStyle(
                                fontSize: 14,
                                color: index == e
                                    ? Colors.white
                                    : Color(0XFF7c7c7c))),
                      ),
                    ))
                .toList(),
            indicatorColor: ColorConfig.WhiteBackColor,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            controller: _tabController,
            labelColor: ColorConfig.ThemeColor,
            labelPadding: EdgeInsets.only(right: 30, left: 30),
            unselectedLabelColor: Colors.black,
            indicatorWeight: 0.1,
            onTap: (int i) {
              setState(() {
                index = i;
                _controller.jumpToPage(i);
              });
            },
          ),
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
        this.pageList[index].page = 1;
        this.pageList[index].isLoad = false;
        this.tabsResult[index] = [];
        await requestType(index);
        _easyRefreshController.finishRefresh(success: true);
      },
      onLoad: () async {
        _easyRefreshController.finishRefresh();
        if (!this.pageList[index].isLoad) {
          this.pageList[index].page++;
          await requestType(index);
        } else {
          await requestType(index);
          // _easyRefreshController.finishLoad(noMore: true);
        }
        _easyRefreshController.finishLoad();
      },
    );
  }

  Widget indexView() {
    return easyRefresh(tabsResult[0].length == 0
        ? Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: SpinKitWave(
                  color: ColorConfig.ThemeColor, itemCount: 3, size: 40),
            ),
          )
        : ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
                GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: tabsResult[0].length,
                    itemBuilder: (BuildContext context, int index) {
                      return _createGridViewItem(index);
                    })
              ]));
  }

  // 排行
  Widget rankingView() {
    return Empty(
      isShow: tabsResult[1].length <= 0,
      child: easyRefresh(
        ListView(
          children: [
            ...tabsResult[1]
                .asMap()
                .keys
                .map((e) => _rankingItemView(tabsResult[1][e]))
                .toList()
          ],
        ),
      ),
    );
  }

  // 排行
  Widget _rankingItemView(OpusRankingEntity data) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed("/worksInfo/${data.opusId}");
      },
      child: Column(
        children: [
          Container(
            height: Screen.setHeight(200),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: NetworkImage(data.opusImg),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: CachedNetworkImage(
              imageUrl: data.opusImg,
              height: Screen.setHeight(200),
              width: Screen.width(context),
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
          ListTile(
            leading: Container(
              height: Screen.setHeight(45),
              width: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ClipOval(
                  child: Image.network(
                    data.userHeadImg,
                    width: Screen.setWidth(38),
                    height: Screen.setWidth(38),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Text(data.userNickname),
            subtitle: Text(
              data.userAutograph,
              maxLines: 1,
              style: TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Container(
              width: Screen.setWidth(40),
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(data.opusSatisfied.toString())
                ],
              ),
            ),
          ),
          Line(),
        ],
      ),
    );
  }

  // 关注列表view
  Widget userViewList() {
    return Empty(
      isShow: tabsResult[2].length <= 0,
      child: easyRefresh(
        GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            ...tabsResult[2].asMap().keys.map((e) => userView(e)).toList()
          ],
        ),
      ),
    );
  }

  // 关注列表
  Widget userView(int e) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed("/worksInfo/${tabsResult[2][e].opusId}");
      },
      child: Container(
        height: Screen.width(context) / 2,
        width: Screen.width(context) / 2,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage(tabsResult[2][e].opusImg),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: CachedNetworkImage(
          imageUrl: tabsResult[2][e].opusImg,
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

  // 根据当前不同下标调用不用接口
  requestType(int e) async {
    if (e == 0) {
      return await getOpusRecommend();
    } else if (e == 1) {
      return await opusRanking();
    } else {
      return await getFollow();
    }
  }

  // 推荐
  getOpusRecommend() async {
    OpusRecommendData res = await OpusService.getOpusRecommend({
      "page": this.pageList[0].page,
      "count": this.pageList[0].count,
    });
    if (res == null) {
      setState(() {
        this.pageList[0].isLoad = true;
      });
      return;
    }
    setState(() {
      this.tabsResult[0] = [...this.tabsResult[0], ...res.result];
    });
  }

  // 排行列表
  opusRanking() async {
    OpusRankingEntityData res = await OpusService.opusRanking({
      "page": this.pageList[1].page,
      "count": this.pageList[1].count,
    });
    if (res == null) {
      setState(() {
        this.pageList[1].isLoad = true;
      });
      return;
    }
    setState(() {
      this.tabsResult[1] = [...this.tabsResult[1], ...res.result];
    });
  }

  // 关注列表
  getFollow() async {
    FollowData res = await OpusService.getFollow({
      "page": this.pageList[2].page,
      "count": this.pageList[2].count,
    });
    if (res == null) {
      setState(() {
        this.pageList[2].isLoad = true;
      });
      return;
    }
    setState(() {
      this.tabsResult[2] = [...this.tabsResult[2], ...res.result];
    });
  }
}
