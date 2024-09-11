import 'package:flutter/cupertino.dart';

class PageEntity {
  int _page = 1;
  int _count = 15;
  bool _isLoad = false;

  set page(int page) => _page = page;
  int get page => _page;
  set count(int count) => _count = count;
  int get count => _count;
  set isLoad(bool isLoad) => _isLoad = isLoad;
  bool get isLoad => _isLoad;

  // PageEntity({int page = 0, int count = 15, bool isLoad}) {
  //   this._page = page;
  //   this._count = count;
  //   this._isLoad = isLoad;
  // }
}
