import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/entity/_.dart';

/*
 * 选择相册或者拍照
 */
class ImagePickerWidget extends StatelessWidget {
  final Widget child;
  final Function onChange;

  const ImagePickerWidget({this.child, this.onChange});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCupertinoActionSheet(context);
      },
      child: child,
    );
  }

  _showCupertinoActionSheet(BuildContext context) async {
    var result = await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(
                '拍照',
                style: TextStyle(color: ColorConfig.ThemeColor),
              ),
              onPressed: () {
                Navigator.of(context).pop('photograph');
              },
              isDefaultAction: true,
            ),
            CupertinoActionSheetAction(
              child: Text(
                '相册',
                style: TextStyle(color: ColorConfig.ThemeColor),
              ),
              onPressed: () {
                Navigator.of(context).pop('album');
              },
              isDefaultAction: true,
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(
              '取消',
              style: TextStyle(color: ColorConfig.ThemeColor),
            ),
            onPressed: () {
              Navigator.of(context).pop('cancel');
            },
          ),
        );
      },
    );

    if (result == 'photograph') {
      image(ImageSource.camera);
    } else if (result == 'album') {
      image(ImageSource.gallery);
    }
  }

  Future image(ImageSource type) async {
    final pickedFile = await ImagePicker().getImage(source: type);
    if (pickedFile != null) {
      onChange(ImagePickerEntity(
          path: File(pickedFile.path), pickedFile: pickedFile));
    }
  }
}
