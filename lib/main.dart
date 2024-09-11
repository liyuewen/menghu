import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/router/AppRouter.dart';
import 'package:peach/Configure.dart';

/*
 * 程序的核心入口
 */
void main() async {
  await Configure.init();
  runApp(ModularApp(module: AppRouter()));
}
