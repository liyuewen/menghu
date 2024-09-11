import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/widget/_.dart';

/*
 * 关注列表
 */
class Follow extends StatefulWidget {
  final int userId;

  const Follow({this.userId});

  @override
  _Follow createState() => _Follow(this.userId);
}

class _Follow extends State<Follow> with SingleTickerProviderStateMixin {
  final int userId;
  _Follow(this.userId);

  EasyRefreshController _easyRefreshController;

  List<FollowUserListEntityResult> fansList = [];

  PageEntity page = PageEntity();

  @override
  void initState() {
    _easyRefreshController = EasyRefreshController();
    super.initState();
    getFansUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Screen.setHeight(45),
        backgroundColor: ColorConfig.ThemeColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "关注列表",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorConfig.WhiteBackColor,
          ),
        ),
      ),
      body: Container(
        height: Screen.height(context) - Screen.setHeight(158),
        child: easyRefresh(ListView(
          children: [
            ...fansList
                .asMap()
                .keys
                .map(
                  (e) => Column(
                    children: [
                      Panel(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    "/personal/${fansList[e].userId}");
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: ClipOval(
                                  child: Image.network(
                                    fansList[e].userHeadImg,
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
                                  Navigator.of(context).pushNamed(
                                      "/personal/${fansList[e].userId}");
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${fansList[e].userNickname}"),
                                      Text("${fansList[e].userAutograph}"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // ElevatedButton(
                            //   style: ButtonStyle(
                            //     backgroundColor:
                            //         MaterialStateProperty.resolveWith((states) {
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
                      Divider(),
                    ],
                  ),
                )
                .toList(),
          ],
        )),
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
        fansList = [];
        page.isLoad = false;
        await getFansUserList();
        _easyRefreshController.finishRefresh(success: true);
      },
      onLoad: () async {
        if (!page.isLoad) {
          page.page += 1;
          await getFansUserList();
          _easyRefreshController.finishLoad();
        } else {
          new Future.delayed(Duration(seconds: 1), () {
            _easyRefreshController.finishLoad();
          });
        }
      },
    );
  }

  getFansUserList() async {
    FollowUserListEntityData res = await UserService.getFollowUserList({
      'user_id': userId,
      'page': page.page,
      'count': page.count,
    });
    if (res == null) return;
    if (res.result.length < page.count) {
      page.isLoad = true;
    }
    setState(() {
      fansList = [...fansList, ...res.result];
    });
  }
}
