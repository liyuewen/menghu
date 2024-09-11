import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:peach/config/Index.dart';
import 'package:peach/router/AppNode.dart';
import 'package:peach/views/App.dart';
import 'package:peach/views/Dynamic/DynamicInfo.dart';
import 'package:peach/views/EditMaterials/EditMaterials.dart';
import 'package:peach/views/Fans/Fans.dart';
import 'package:peach/views/Follow/Follow.dart';
import 'package:peach/views/Index/IndexResultsList.dart';
import 'package:peach/views/Index/IndexSearch.dart';
import 'package:peach/views/Personal/Personal.dart';
import 'package:peach/views/PublishingWorks/PublishingWorks.dart';
import 'package:peach/views/ReleaseNews/ReleaseNews.dart';
import 'package:peach/views/SignUp/SignUp.dart';
import 'package:peach/views/Welcome.dart';
import 'package:peach/views/WorksInfo/WorksInfo.dart';

/*
 * 路由配置
 */
class AppRouter extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          child: (_, __) => Config.isFirstOpen
              ? Welcome()
              : Config.isLogin
                  ? SignUp()
                  : App(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/signUp',
          child: (_, __) => SignUp(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/index',
          child: (_, __) => App(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/worksInfo/:opusId',
          child: (_, __age) =>
              WorksInfo(opusId: int.parse(__age.params['opusId'])),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/publishingWorks',
          child: (_, __) => PublishingWorks(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/editMaterials',
          child: (_, __) => EditMaterials(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/indexSearch',
          child: (_, __) => IndexSearch(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/releaseNews',
          child: (_, __) => ReleaseNews(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/dynamicInfo/:dynamicId',
          child: (_, __age) =>
              DynamicInfo(dynamicId: __age.params['dynamicId']),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/indexResultsList/:affKeyword/:afferentType',
          child: (_, __age) => IndexResultsList(
            affKeyword: __age.params["affKeyword"],
            afferentType: int.parse(__age.params["afferentType"]),
          ),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/personal/:userId',
          child: (_, __age) =>
              Personal(userId: int.parse(__age.params["userId"])),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/fans/:userId',
          child: (_, __age) => Fans(userId: int.parse(__age.params["userId"])),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/follow/:userId',
          child: (_, __age) =>
              Follow(userId: int.parse(__age.params["userId"])),
          transition: TransitionType.fadeIn,
        ),
      ];

  @override
  Widget get bootstrap => AppNode();
}
