import 'package:flow_camp_app/pages/LikeListPage.dart';
import 'package:flow_camp_app/pages/main_setting_page.dart';
import 'package:flow_camp_app/pages/profile_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabNavigationPage extends StatefulWidget {
  const TabNavigationPage({Key? key}) : super(key: key);

  @override
  State<TabNavigationPage> createState() => _TabNavigationPageState();
}

class _TabNavigationPageState extends State<TabNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: 'Like',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
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
