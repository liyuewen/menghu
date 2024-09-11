import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/views/Index/Index.dart';
import 'package:peach/widget/Empty.dart';
import 'package:peach/widget/_.dart';

import 'dart:convert';

/*
 * 搜索结果列表页
 */
class IndexResultsList extends StatefulWidget {
  final String affKeyword;

  final int afferentType;

  const IndexResultsList({this.affKeyword, this.afferentType = 0});

  @override
  _IndexResultsList createState() =>
      _IndexResultsList(affKeyword, afferentType);
}

class _IndexResultsList extends State<IndexResultsList>
    with SingleTickerProviderStateMixin {
  final String affKeyword;

  final int afferentType;

  TextEditingController _controller;

  TabController _tabController;
  PageController _pageController;

  EasyRefreshController _easyRefreshController;

  // 当前搜索类型
  int type = 0;

  List<String> typeList = ['opus', 'user', 'tag'];

  // 搜索值
  String keyword = '';

  List<PageEntity> page = [PageEntity(), PageEntity(), PageEntity()];

  List<List<dynamic>> listData = [[], [], []];

  bool lock = false;

  _IndexResultsList(this.affKeyword, this.afferentType);

  bool loading = true;

  @override
  void initState() {
    //初始化，这个函数在生命周期中只调用一次
    super.initState();
    _tabController =
        TabController(initialIndex: this.afferentType, length: 3, vsync: this);
    _pageController = PageController(initialPage: this.afferentType);
    type = this.afferentType;
    _easyRefreshController = EasyRefreshController();
    _controller = TextEditingController();
    httpCall();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Loading();
    return Scaffold(
      appBar: AppBar(
        title: search(),
        centerTitle: true,
        backgroundColor: ColorConfig.ThemeColor,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Material(
            //这里设置tab的背景色
            color: ColorConfig.WhiteBackColor,
            child: TabBar(
              controller: _tabController,
              tabs: [Tab(text: "作品"), Tab(text: "用户"), Tab(text: "标签")],
              isScrollable: true,
              indicatorColor: ColorConfig.ThemeColor,
              indicatorWeight: 2,
              // indicatorPadding: EdgeInsets.only(left: 20, right: 20),
              // in
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: ColorConfig.ThemeColor,
              labelStyle: TextStyle(fontSize: 15),
              labelPadding:
                  EdgeInsets.only(left: 50, top: 0, right: 50, bottom: 0),
              unselectedLabelColor: ColorConfig.TextColor,
              unselectedLabelStyle: TextStyle(fontSize: 15),
              onTap: (index) {
                setType(index);
                _pageController.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
      body: Container(
        height: Screen.height(context) - Config.top,
        margin: EdgeInsets.only(top: 2, bottom: 2),
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            indexView(),
            userViewList(),
            tagView(),
          ],
          onPageChanged: (index) {
            // setType(index);
            _tabController.animateTo(index);
          },
        ),
      ),
    );
    ;
  }

  Widget search() {
    return Container(
      width: Screen.width(context),
      height: Screen.setHeight(28),
      decoration: BoxDecoration(
        color: ColorConfig.WhiteBackColor,
        borderRadius: BorderRadius.all(Radius.circular(28.0)),
      ),
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        onSubmitted: (res) {
          keyword = res;
          page[0].page = 1;
          page[1].page = 1;
          page[2].page = 1;
          listData[0] = [];
          listData[1] = [];
          listData[2] = [];
          opusSearch();
        },
        decoration: InputDecoration(
          isDense: true,
          hintText: "请输入关键字",
          prefixIcon: Icon(
            Icons.search,
            color: ColorConfig.TextColor,
            size: 20,
          ),
          fillColor: ColorConfig.ThemeColor,
          labelStyle: TextStyle(color: ColorConfig.ThemeColor),
          enabledBorder: UnderlineInputBorder(
            //选中时下边框颜色
            borderSide: BorderSide(color: ColorConfig.ThemeColor),
          ),
          focusedBorder: UnderlineInputBorder(
            //选中时下边框颜色
            borderSide: BorderSide(color: ColorConfig.ThemeColor),
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
        page[type].page = 1;
        listData[type] = [];
        await opusSearch();
        _easyRefreshController.finishRefresh(success: true);
      },
      onLoad: () async {
        _easyRefreshController.finishRefresh();
        if (!page[type].isLoad) {
          page[type].page++;
          await opusSearch();
          _easyRefreshController.finishLoad();
        } else {
          new Future.delayed(Duration(seconds: 1), () {
            _easyRefreshController.finishLoad();
          });
        }
      },
    );
  }

  Widget indexView() {
    return Empty(
      isShow: listData[0].length <= 0,
      child: easyRefresh(
        GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            ...listData[0]
                .asMap()
                .keys
                .map((e) => _createGridViewItem(listData[0][e]))
                .toList()
          ],
        ),
      ),
    );
  }

  Widget tagView() {
    return Empty(
      isShow: listData[2].length <= 0,
      child: easyRefresh(
        GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            ...listData[2]
                .asMap()
                .keys
                .map((e) => _createGridViewItem(listData[2][e]))
                .toList()
          ],
        ),
      ),
    );
  }

  // 用户列表view
  Widget userViewList() {
    return Empty(
      isShow: listData[1].length <= 0,
      child: easyRefresh(ListView(
        children: [
          ...listData[1]
              .asMap()
              .keys
              .map((e) => userView(listData[1][e]))
              .toList()
        ],
      )),
    );
  }

  Widget userView(OpusSearchUserEntityResult data) {
    return Column(
      children: [
        Panel(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/personal/${data.userId}");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: ClipOval(
                    child: Image.network(
                      data.userHeadImg,
                      width: Screen.setWidth(40),
                      height: Screen.setWidth(40),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/personal/${data.userId}");
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data.userNickname}"),
                        Text(
                          "${data.userAutograph}",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.resolveWith((states) {
              //       //默认不使用背景颜色
              //       return ColorConfig.ThemeColor;
              //     }),
              //   ),
              //   child: Text('关注'),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }

  // 推荐item样式
  _createGridViewItem(OpusSearchTagEntityResult data) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed("/worksInfo/${data.opusId}");
      },
      child: Container(
        height: Screen.width(context) / 2,
        width: Screen.width(context) / 2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(data.opusImg),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  httpCall() async {
    keyword = affKeyword;
    _controller.text = affKeyword;
    await this.opusSearch();
    setState(() {
      loading = false;
    });
  }

  setType(int i) async {
    type = i;
    if (listData[type].length <= 0) {
      await opusSearch();
    }
  }

  opusSearch() async {
    var content = utf8.encode(keyword);
    var digest = base64Encode(content);
    dynamic res = await OpusService.opusSearch({
      "keyword": digest,
      "type": typeList[type],
      "page": page[type].page,
      "count": page[type].count,
    });
    dynamic rel;
    if (type == 0) {
      rel = OpusSearchTagEntityList.fromJson(res).data;
    } else if (type == 1) {
      rel = OpusSearchUserEntityList.fromJson(res).data;
    } else if (type == 2) {
      rel = OpusSearchTagEntityList.fromJson(res).data;
    }
    if (rel == null) {
      return;
    }
    listData[type] = [...listData[type], ...rel.result];
    if (rel.result.length < page[type].count) {
      page[type].isLoad = true;
    }
    setState(() {});
  }
}
