import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/utils/_.dart';

/*
 * 作品的数据展示 点赞 评论 浏览
 */
class WorkDataView extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final OpusOpusInfoEntityData infoData;
  final bool isUpvote;
  final Function onUpvote;
  final bool isCollectionOpus;
  final Function onOpusCollectionOpus;

  const WorkDataView({
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.infoData,
    this.isUpvote = false,
    this.onUpvote,
    this.isCollectionOpus = false,
    this.onOpusCollectionOpus,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {
                onUpvote();
              },
              child: Row(
                mainAxisAlignment: this.mainAxisAlignment,
                children: [
                  Icon(
                    Icons.thumb_up,
                    size: 18,
                    color: isUpvote
                        ? ColorConfig.ThemeColor
                        : ColorConfig.TextColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    infoData.opusSatisfied.toString(),
                    style: TextStyle(
                      color: ColorConfig.TextColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {
                onOpusCollectionOpus();
              },
              child: Row(
                mainAxisAlignment: this.mainAxisAlignment,
                children: [
                  Icon(
                    Icons.favorite,
                    size: 18,
                    color: isCollectionOpus
                        ? ColorConfig.ThemeColor
                        : ColorConfig.TextColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    infoData.opusCollection.toString(),
                    style: TextStyle(
                      color: ColorConfig.TextColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: this.mainAxisAlignment,
              children: [
                Icon(
                  Icons.visibility,
                  size: 18,
                  color: ColorConfig.TextColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  infoData.opusSee.toString(),
                  style: TextStyle(
                    color: ColorConfig.TextColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
