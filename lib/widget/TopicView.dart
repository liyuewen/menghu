import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/entity/_.dart';

/*
 * 话题展示
 */
class TopicView extends StatelessWidget {
  final Function onTap;

  final List<Tags> tag;

  final bool edit;

  const TopicView({this.tag, this.onTap, this.edit = false});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 3,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...tag.map((e) {
          return GestureDetector(
            onTap: () {
              Modular.to.pushNamed("/indexResultsList/${e.tagsTitle}/${2}");
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Text(
                "#${e.tagsTitle}",
                style: TextStyle(
                  color: ColorConfig.ThemeColor,
                ),
              ),
            ),
          );
        }).toList(),
        edit
            ? GestureDetector(
                onTap: () {
                  onTap();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "编辑",
                    style: TextStyle(
                      color: ColorConfig.ThemeColor,
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
