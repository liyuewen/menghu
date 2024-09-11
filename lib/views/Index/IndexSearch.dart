import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/service/TagService.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/views/Dynamic/Topic.dart';
import 'package:peach/widget/Panel.dart';

import 'dart:convert';
import 'dart:convert' as convert;

import 'package:peach/widget/_.dart';

/*
 * 首页搜索页
 */
class IndexSearch extends StatefulWidget {
  final Function clickHead;

  const IndexSearch({Key key, this.clickHead}) : super(key: key);
  @override
  _IndexSearch createState() => _IndexSearch();
}

class _IndexSearch extends State<IndexSearch>
    with SingleTickerProviderStateMixin {
  TextEditingController _controller;

  List<TagRecommendTagEntityData> recommendTagList = [];

  List<String> historyList = [];

  @override
  void initState() {
    super.initState();
    // SharedPreferences 初始化
    SPreferences.init();
    getHistory();
    _controller = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: search(),
            toolbarHeight: Screen.setHeight(40),
            centerTitle: true,
            backgroundColor: ColorConfig.ThemeColor,
          ),
          body: Container(
            height: Screen.height(context) - Screen.setHeight(45) - Config.top,
            width: Screen.width(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Screen.setHeight(140),
                  child: Topic(
                      topicList: recommendTagList,
                      onTap: (rel) {
                        setHistory(rel);
                        Modular.to.pushNamed("/indexResultsList/$rel/0");
                      }),
                ),
                Container(
                  height: Screen.setHeight(200),
                  child: titleSection(
                      "历史搜索",
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        runSpacing: 5,
                        spacing: 10,
                        children: [
                          ...historyList
                              .asMap()
                              .keys
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    String res = historyList[e];
                                    setHistory(res);
                                    Modular.to.pushNamed(
                                      "/indexResultsList/${res}/0",
                                    );
                                  },
                                  child: Text(
                                    historyList[e],
                                    style: TextStyle(
                                        color: ColorConfig.ThemeColor,
                                        fontSize: 16),
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
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
          _controller.text = "";
          setHistory(res);
          Modular.to.pushNamed("/indexResultsList/$res/0");
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

  Widget titleSection(String title, Widget child) {
    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //分析 2
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }

  future() async {
    await tagRecommendTag();
  }

  tagRecommendTag() async {
    List<TagRecommendTagEntityData> res = await TagService.tagRecommendTag({});
    if (res != null) {
      recommendTagList = res.take(5).toList();
    }
  }

  setHistory(String value) {
    int index = historyList.indexOf(value);
    if (index == -1) {
      setHistoryList(value);
      return;
    }
    historyList.remove(value);
    setHistoryList(value);
  }

  getHistory() {
    String res = SPreferences().getString("historyList");
    print(res);
    if (res != null) {
      List<String> res =
          jsonDecode(SPreferences().getString("historyList")).cast<String>();
      historyList = res;
    }
  }

  setHistoryList(String value) {
    historyList = [value, ...historyList];
    SPreferences().setString("historyList", convert.jsonEncode(historyList));
    setState(() {});
  }
}
