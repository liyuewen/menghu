import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/entity/CommenListEntity.dart';
import 'package:peach/utils/_.dart';
import 'package:peach/entity/_.dart';

import '_.dart';

/*
 * 评论样式
 */
class CommentList extends StatelessWidget {
  final List<CommenListEntity> comment;
  final Function reply;

  const CommentList({this.comment, this.reply});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...comment.asMap().keys.map((e) {
          return view(comment[e]);
        }).toList(),
      ],
    );
  }

  Widget view(CommenListEntity data) {
    if (data.child.length <= 0) {
      return CommentWidget(
          comment: data,
          reply: () {
            reply(data.userNickname, data.commentId);
          });
    } else {
      return Column(
        children: [
          CommentWidget(
              comment: data,
              reply: () {
                reply(data.userNickname, data.commentId);
              }),
          ...data.child.asMap().keys.map((e) {
            return Container(
              margin: EdgeInsets.only(left: Screen.setWidth(40)),
              child: CommentWidget(
                  child: data.child[e],
                  userNickname: "@ ${data.child[e].userNickname}",
                  reply: () {
                    reply(data.child[e].userNickname, data.commentId);
                  }),
            );
          }).toList()
        ],
      );
    }
  }
}
