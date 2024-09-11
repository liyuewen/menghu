import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/DynamicDynamicHistoryEntity.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/widget/_.dart';

/*
 * 动态
 */

class MostFrequently extends StatelessWidget {
  final List<DynamicDynamicHistoryEntity> history;

  const MostFrequently({this.history});

  @override
  Widget build(BuildContext context) {
    return Panel(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 1, child: Text("最近访问")),
              // Row(
              //   children: [
              //     Text(
              //       "查看更多",
              //       style: TextStyle(color: ColorConfig.TextColor),
              //     ),
              //     Icon(
              //       Icons.arrow_forward_ios,
              //       size: 12,
              //       color: ColorConfig.TextColor,
              //     )
              //   ],
              // )
            ],
          ),
          history.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: 11),
                  height: Screen.setHeight(58),
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: ClipOval(
                                child: Image.network(
                                  history[index].userHeadImg,
                                  width: Screen.setWidth(50),
                                  height: Screen.setWidth(50),
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Text(
                            history[index].userNickname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      );
                    },
                    itemCount: history.length,
                  ),
                )
              : EmptyText()
        ],
      ),
    );
  }
}
