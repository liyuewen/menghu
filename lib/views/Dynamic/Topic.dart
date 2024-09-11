import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/widget/_.dart';

/*
 * 话题
 */
// class Topic extends StatefulWidget {
//   final List<TagRecommendTagEntityData> topicList;
//   final TagRecommendTagEntityData topic;

//   Topic({this.topicList, this.topic});

//   @override
//   _Topic createState() => _Topic(this.topicList, this.topic);
// }

class Topic extends StatelessWidget {
  final List<TagRecommendTagEntityData> topicList;

  final Function onTap;

  Topic({this.topicList, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Panel(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("话题"),
          ),
          topicList.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: 11),
                  height: Screen.setHeight(90),
                  child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 10 / 2),
                    children: [
                      ...topicList
                          .asMap()
                          .keys
                          .map((e) => RowItem(topicList[e].tagsTitle))
                          .toList()
                    ],
                  ),
                )
              : EmptyText()
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget RowItem(String title) {
    return GestureDetector(
      onTap: () {
        onTap(title);
      },
      child: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Text(
          title,
          style: TextStyle(color: ColorConfig.Jump),
        ),
      ),
    );
  }
}
