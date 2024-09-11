import 'package:flutter/material.dart';
import 'package:peach/config/_.dart';
import 'package:peach/utils/_.dart';

import 'Appointment/Appointment.dart';
import 'Customized/Customized.dart';
import 'Dynamic/Dynamic.dart';
import 'Index/Index.dart';
import 'Index/PersonalpPop.dart';
import 'Personal/Personal.dart';

/**
 * 有状态StatefulWidget
 *  继承于 StatefulWidget，通过 State 的 build 方法去构建控件
 */
class App extends StatefulWidget {
  App();

  //主要是负责创建state
  @override
  BotomeMenumTabBarPageState createState() => BotomeMenumTabBarPageState();
}

/**
 * 在 State 中,可以动态改变数据
 * 在 setState 之后，改变的数据会触发 Widget 重新构建刷新
 */
class BotomeMenumTabBarPageState extends State<App>
    with SingleTickerProviderStateMixin {
  BotomeMenumTabBarPageState();
  TabController tabController;
  @override
  void initState() {
    ///初始化，这个函数在生命周期中只调用一次
    super.initState();
    // CheckUpdate().check(context);
    tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Config.context = context;
    //构建页面
    Core.barColor(Colors.transparent);
    return new Scaffold(
        extendBody: true,
        body: new TabBarView(controller: tabController, children: [
          Builder(builder: (BuildContext context) {
            return Index(clickHead: () => {Scaffold.of(context).openDrawer()});
          }),
          Appointment(),
          Dynamic(),
          Customized(),
          // Personal()
        ]),
        bottomNavigationBar: Container(
          height: Screen.setHeight(50),
          decoration: new BoxDecoration(
            color: ColorConfig.WhiteBackColor,
            border: new Border(top: BorderSide(color: ColorConfig.LineColor)),
          ),
          child: new TabBar(
            indicatorColor: Colors.transparent,
            labelColor: ColorConfig.ThemeColor,
            unselectedLabelColor: ColorConfig.TextColor,
            controller: tabController,
            tabs: <Tab>[
              new Tab(text: "首页", icon: new Icon(Icons.home)),
              new Tab(text: "约稿", icon: new Icon(Icons.find_in_page)),
              new Tab(text: "动态", icon: new Icon(Icons.message)),
              new Tab(text: "定制", icon: new Icon(Icons.person)),
              // new Tab(text: "个人", icon: new Icon(Icons.person)),
            ],
            indicatorWeight: 0.1,
            labelStyle: TextStyle(height: 0.5),
          ),
        ),
        drawer: PersonalpPop());
  }
}
