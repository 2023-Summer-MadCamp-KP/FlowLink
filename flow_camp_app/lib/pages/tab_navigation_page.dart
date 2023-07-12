import 'package:flow_camp_app/pages/like_list_page.dart';
import 'package:flow_camp_app/pages/main_setting_page.dart';
import 'package:flow_camp_app/pages/profile_list_page.dart';
import 'package:flow_camp_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabNavigationPage extends StatefulWidget {
  const TabNavigationPage({Key? key}) : super(key: key);

  @override
  State<TabNavigationPage> createState() => _TabNavigationPageState();
}

class _TabNavigationPageState extends State<TabNavigationPage> {
  void apiInit() async {
    var provider = context.read<UserProvider>();
    await provider.getMe();
    await provider.getUsers();
    await provider.getLike();
     await provider.getWhoLike();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: '프로필',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: '좋아요',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble),
            label: '메세지',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: '설정',
          ),
        ],
        onTap: (int index) {
          apiInit();
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        // apiInit();
        return CupertinoTabView(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                return ProfileListPage();
              case 1:
                return LikeListPage();
              case 2:
                return Placeholder();
              case 3:
                return MainSettingPage();
              default:
                return Container();
            }
          },
        );
      },
    );
  }
}
