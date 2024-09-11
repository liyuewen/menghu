import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/event/_.dart';
import 'package:peach/service/TagService.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/views/Dynamic/DynamicItem.dart';
import 'package:peach/views/Dynamic/Topic.dart';
import 'package:peach/widget/_.dart';

import 'MostFrequently.dart';

/*
 * 动态
 */
class Dynamic extends StatefulWidget {
  @override
  _Dynamic createState() => _Dynamic();
}

class _Dynamic extends State<Dynamic> {
  EasyRefreshController _easyRefreshController;
  List<DynamicTabsDynamicEntity> dynamicList = [];
  List<DynamicDynamicHistoryEntity> history = [];
  List<TagRecommendTagEntityData> recommendTagList = [];

  PageEntity page = PageEntity();

  @override
  void initState() {
    _easyRefreshController = EasyRefreshController();
    super.initState();
    future();
    listenChange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Screen.setHeight(82),
        backgroundColor: ColorConfig.WhiteBackColor,
        elevation: 0,
        leading: SizedBox(width: 0.1),
        title: Align(
          alignment: Alignment.center,
          child: Text("动态",
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorConfig.TitleColor)),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/releaseNews");
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              width: Screen.setWidth(45),
              child: Icon(Icons.edit_road, color: ColorConfig.TitleColor),
            ),
          )
        ],
        bottom: bottom(),
      ),
      body: Container(
        height: Screen.height(context) - Screen.setHeight(158),
        child: easyRefresh(Column(
          children: [
            MostFrequently(
              history: history,
            ),
            Column(
              children: [
                Line(),
                Topic(
                  topicList: recommendTagList,
                )
              ],
            ),
            ...dynamicList
                .asMap()
                .keys
                .map((e) => DynamicItem(dynamicData: dynamicList[e]))
                .toList(),
          ],
        )),
      ),
    );
  }

  Widget bottom() {
    return PreferredSize(
      preferredSize: Size.fromHeight(45),
      child: Container(
        height: Screen.setHeight(37),
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(
              color: ColorConfig.LineColor, width: 1, style: BorderStyle.solid),
          bottom: BorderSide(
              color: ColorConfig.LineColor, width: 1, style: BorderStyle.solid),
        )),
        child: Align(
          alignment: Alignment.center,
          child: Panel(
            top: 5,
            bottom: 5,
            child: ExhibitionSearch(
              backgroundColor: ColorConfig.AshPlacement,
            ),
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
        page.page = 1;
        dynamicList = [];
        page.isLoad = false;
        await dynamicPersonalDynamic();
        _easyRefreshController.finishRefresh(success: true);
      },
      onLoad: () async {
        if (!page.isLoad) {
          page.page += 1;
          await dynamicPersonalDynamic();
          _easyRefreshController.finishLoad();
        } else {
          new Future.delayed(Duration(seconds: 1), () {
            _easyRefreshController.finishLoad();
          });
        }
      },
    );
  }

  listenChange() {
    Config.eventBus.on<ClassEditEvent>().listen((event) {
      print("${event.update}-------");
      if (event.update) {
        print(1);
        page.page = 1;
        dynamicList = [];
        future();
      }
    });
  }

  future() async {
    await dynamicPersonalDynamic();
    await dynamicDynamicHistory();
    await tagRecommendTag();
    setState(() {});
  }

  dynamicPersonalDynamic() async {
    DynamicTabsDynamicEntityData res = await DynamicService.dynamicTabsDynamic(
        {"page": page.page, "count": page.count});
    if (res == null) return;
    if (res.result.length < page.count) {
      page.isLoad = true;
    }
    dynamicList = [...dynamicList, ...res.result];
  }

  dynamicDynamicHistory() async {
    DynamicDynamicHistoryEntityData res =
        await DynamicService.dynamicDynamicHistory({"page": 1, "count": 50});
    if (res == null) return;
    history = res.result;
  }

  tagRecommendTag() async {
    List<TagRecommendTagEntityData> res = await TagService.tagRecommendTag({});
    if (res == null) return;
    recommendTagList = res.take(5).toList();
  }
}
