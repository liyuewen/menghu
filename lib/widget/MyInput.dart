import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/_.dart';
import 'package:peach/utils/_.dart';

class MyInput extends StatefulWidget {
  final String hintText;

  const MyInput({this.hintText});

  @override
  _MyInput createState() => _MyInput(hintText: hintText);
}

/*
 * 评论输入框
 */
class _MyInput extends State {
  FocusNode focusNode = FocusNode();
  TextEditingController textFieldcontroller;
  ChatType currentType = ChatType.text;
  final String hintText;

  double height = 70;

  _MyInput({this.hintText = "君观之有言否?"}) {
    focusNode.addListener(onFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screen.setHeight(height),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: ColorConfig.LineColor, width: 1),
        ),
      ),
      child: Column(
        children: [
          buildInputButton(),
          buildEmojiButton(),
        ],
      ),
    );
  }

  Widget buildInputButton() {
    return Container(
      height: Screen.setHeight(35),
      padding: EdgeInsets.only(top: 15),
      child: TextField(
        focusNode: focusNode,
        controller: textFieldcontroller,
        cursorHeight: 20,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget buildEmojiButton() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 25,
      ),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 32,
        color: ColorConfig.TextColor,
        padding: EdgeInsets.only(top: 0),
        icon: currentType != ChatType.emoji
            ? Icon(Icons.mood)
            : Icon(Icons.keyboard),
        onPressed: () {
          if (currentType != ChatType.emoji) {
            updateState(ChatType.emoji);
          } else {
            updateState(ChatType.text);
          }
        },
      ),
    );
  }

  onFocus() {
    // print("${focusNode.hasFocus}88888");
    // height = 200;
  }

  updateState(ChatType type) {
    if (type == ChatType.text) {
      height = 70;
      FocusScope.of(context).requestFocus(focusNode);
    } else {
      height = 200;
      focusNode.unfocus();
    }
    print(height);
    setState(() {
      currentType = type;
    });
  }
}

enum ChatType {
  text,
  emoji,
}
