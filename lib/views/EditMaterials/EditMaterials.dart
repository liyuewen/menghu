import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/utils/Screen.dart';
import 'package:peach/widget/Panel.dart';

/*
 * 编辑资料
 */
class EditMaterials extends StatefulWidget {
  @override
  _EditMaterials createState() => _EditMaterials();
}

class _EditMaterials extends State<EditMaterials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConfig.WhiteBackColor,
        centerTitle: true,
        title: Text(
          '编辑个人资料',
          style: TextStyle(color: ColorConfig.BlackBackColor),
        ),
        iconTheme: IconThemeData(
          color: ColorConfig.BlackBackColor,
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10),
            child: TextButton(
              child: Text(
                "保存",
                style: TextStyle(color: ColorConfig.TextColor, fontSize: 18),
              ),
              onPressed: () {
                print("文字按钮");
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Panel(
            child: Column(
              children: [
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://upload.jianshu.io/users/upload_avatars/5685558/23e20d58-c5e1-4fd6-90d4-a3752cbe7d6a"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: Screen.setHeight(77),
                        width: Screen.setHeight(77),
                        child: Container(
                          color: Color.fromRGBO(0, 0, 0, .3),
                          child: Icon(
                            Icons.party_mode,
                            color: ColorConfig.LineColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "点击更换头像",
                    style:
                        TextStyle(color: ColorConfig.TextColor, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          itemListTile(title: Text('昵称'), trailing: rightText("昵称")),
          itemListTile(title: Text('简介'), trailing: rightText("简介")),
          itemListTile(title: Text('性别'), trailing: rightText("性别")),
          itemListTile(title: Text('出生日期'), trailing: rightText("地区")),
          itemListTile(title: Text('地区'), trailing: rightText("地区"))
        ],
      ),
    );
  }

  Widget itemListTile({Widget title, Widget trailing}) {
    return Column(
      children: [
        ListTile(
          title: Text('地区'),
          trailing: trailing,
        ),
        Divider(height: 1),
      ],
    );
  }

  Widget rightText(String text) {
    return Container(
      width: Screen.setWidth(200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(text),
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
          )
        ],
      ),
    );
  }
}
