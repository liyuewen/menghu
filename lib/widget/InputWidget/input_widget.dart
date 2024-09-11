import 'dart:async';

import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/_.dart';
import 'package:peach/event/_.dart';
import 'dart:ui' as ui;

import 'package:peach/utils/Screen.dart';

typedef void OnSend(String text);

ChatType _initType = ChatType.text;

double _softKeyHeight = 324.0;

class InputWidget extends StatefulWidget {
  final TextEditingController controller;
  final Widget extraWidget;
  final Widget emojiWidget;
  final Widget voiceWidget;
  final OnSend onSend;
  final Function onFocusNode;
  final String hintText;

  const InputWidget({
    Key key,
    @required this.controller,
    this.extraWidget,
    this.emojiWidget,
    this.voiceWidget,
    this.onSend,
    this.onFocusNode,
    this.hintText = "回复",
  }) : super(key: key);

  @override
  InputWidgetState createState() =>
      InputWidgetState(this.onSend, this.onFocusNode);
}

class InputWidgetState extends State<InputWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final Function onSend;
  final Function onFocusNode;
  String hintText = "回复";

  ChatType currentType = _initType;

  FocusNode focusNode = FocusNode();

  StreamController<String> inputContentStreamController =
      StreamController.broadcast();

  InputWidgetState(this.onSend, this.onFocusNode);

  Stream<String> get inputContentStream => inputContentStreamController.stream;

  AnimationController _bottomHeightController;

  double maxHeight = 90;

  List<Emoji> emList = Emoji.all().take(100).toList();

  Color butColor = ColorConfig.TextColor;

  @override
  void initState() {
    super.initState();
    onFocusNode(focusNode);
    WidgetsBinding.instance.addObserver(this);
    focusNode.addListener(onFocus);
    widget.controller.addListener(_onInputChange);
    _bottomHeightController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 250,
      ),
    );

    Config.eventBus.on<ClasshHntTextEvent>().listen((event) {
      if (event.text != "") {
        hintText = event.text;
      }
    });
  }

  // bool checkShowSendButton(String text) {
  //   if (currentType == ChatType.voice) {
  //     return false;
  //   }
  //   if (text.trim().isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // }

  @override
  void didChangeMetrics() {
    final mediaQueryData = MediaQueryData.fromWindow(ui.window);
    final keyHeight = mediaQueryData?.viewInsets?.bottom;
    if (keyHeight != 0) {
      _softKeyHeight = keyHeight;
      // updateState(ChatType.text);
    } else {
      // setState(() {});
    }
  }

  void onFocus() {
    if (focusNode.hasFocus) {
      updateState(ChatType.text);
    }
  }

  void _onInputChange() {
    inputContentStreamController.add(widget.controller.text);
    if (widget.controller.text.length > 0) {
      butColor = ColorConfig.ThemeColor;
    } else {
      butColor = ColorConfig.TextColor;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _bottomHeightController.dispose();
    inputContentStreamController.close();
    widget.controller.removeListener(_onInputChange);
    focusNode.removeListener(onFocus);
    focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 390),
      child: Container(
        height: maxHeight,
        // decoration: BoxDecoration(
        //   border: Border(
        //     top: BorderSide(color: ColorConfig.LineColor, width: 1),
        //   ),
        // ),
        child: Column(
          children: <Widget>[
            buildInputButton(),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildEmojiButton(),
                  buildRightButton(),
                ],
              ),
            ),
            // Divider(),
            _buildBottomContainer(child: _buildBottomItems())
          ],
        ),
      ),
    );
  }

  Widget buildRightButton() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 25,
      ),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 32,
        color: butColor,
        enableFeedback: true,
        padding: EdgeInsets.only(top: 0),
        icon: Icon(Icons.send),
        onPressed: () {
          if (widget.controller.text.length <= 0) return;
          this.onSend(widget.controller.text);
          widget.controller.text = "";
        },
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

  Widget buildInputButton() {
    final inputButton = TextField(
      focusNode: focusNode,
      controller: widget.controller,
      cursorHeight: 20,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );

    return Container(
      height: Screen.setHeight(35),
      padding: EdgeInsets.only(top: 15),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 25,
        ),
        child: inputButton,
      ),
    );
  }

  void changeBottomHeight(final double height) {
    if (height > 0) {
      _bottomHeightController.animateTo(1);
    } else {
      _bottomHeightController.animateBack(0);
    }
  }

  Future<void> updateState(ChatType type) async {
    if (type == ChatType.text || type == ChatType.voice) {
      _initType = type;
    }
    if (type == currentType) {
      return;
    }
    this.currentType = type;
    ChangeChatTypeNotification(type).dispatch(context);

    if (type != ChatType.text) {
      hideSoftKey();
      setState(() {
        maxHeight = 390;
      });
    } else {
      showSoftKey();
      setState(() {
        maxHeight = 90;
      });
    }

    if (type == ChatType.emoji || type == ChatType.extra) {
      // _currentOtherHeight = _softKeyHeight;
      changeBottomHeight(1);
    } else {
      changeBottomHeight(0);
      // _currentOtherHeight = 0;
    }

    setState(() {});
  }

  void showSoftKey() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void hideSoftKey() {
    focusNode.unfocus();
  }

  Widget _buildBottomContainer({Widget child}) {
    return SizeTransition(
      sizeFactor: _bottomHeightController,
      child: Container(
        child: child,
        height: 300,
      ),
    );
  }

  Widget _buildBottomItems() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1, color: ColorConfig.LineColor)),
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          children: [
            ...emList.asMap().keys.map(
              (e) {
                return GestureDetector(
                  onTap: () {
                    widget.controller.text += emList[e].toString();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${emList[e]}",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}

enum ChatType {
  text,
  voice,
  emoji,
  extra,
}

class ChangeChatTypeNotification extends Notification {
  final ChatType type;

  ChangeChatTypeNotification(this.type);
}
