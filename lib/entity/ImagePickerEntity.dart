import 'dart:io';

import 'package:image_picker/image_picker.dart';

/*
  选择后的图片实体
 */
class ImagePickerEntity {
  // 图片地址
  File path;
  // 图片文件
  PickedFile pickedFile;

  String netWorkPath;

  ImagePickerEntity({this.path, this.pickedFile, this.netWorkPath});

  File get getPath => path;
  set setPath(File path) => path = path;

  PickedFile get getPickedFile => pickedFile;
  set setPickedFile(PickedFile pickedFile) => pickedFile = pickedFile;

  String get getNetWorkPath => netWorkPath;
  set setNetWorkPath(File netWorkPath) => netWorkPath = netWorkPath;
}
