import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/CommenListEntity.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/utils/Screen.dart';
import 'package:peach/widget/Panel.dart';

/*
 * 评论样式
 */
class CommentWidget extends StatelessWidget {
  final Function reply;
  final CommenListEntity comment;
  final String userNickname;

  final Child child;

  CommentWidget({this.reply, this.comment, this.child, this.userNickname = ""});

  var data;

  @override
  Widget build(BuildContext context) {
    data = comment != null ? comment : child;
    return Panel(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Modular.to.pushNamed("/personal/${comment.userId}");
            },
            child: Container(
              height: Screen.setWidth(35),
              width: Screen.setWidth(35),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(data.userHeadImg),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.userNickname,
                    style: TextStyle(fontSize: 14),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text.rich(
                      TextSpan(
                        text: "${userNickname}",
                        style: TextStyle(
                          fontSize: 13,
                          color: ColorConfig.ThemeColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Modular.to.pushNamed("/personal/${data.userId}");
                          },
                        children: [
                          TextSpan(
                            text: data.commentContent,
                            style: TextStyle(
                              color: ColorConfig.TextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            data.commentTime,
                            style: TextStyle(
                                color: ColorConfig.TextColor, fontSize: 13),
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            "回复",
                            style: TextStyle(
                              fontSize: 13,
                              color: ColorConfig.ThemeColor,
                            ),
                          ),
                          onTap: () {
                            reply();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
