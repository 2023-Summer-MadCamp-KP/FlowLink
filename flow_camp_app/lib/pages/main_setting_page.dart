import 'package:flow_camp_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'input_info1_page.dart';

class MainSettingPage extends StatefulWidget {
  const MainSettingPage({Key? key}) : super(key: key);

  @override
  State<MainSettingPage> createState() => _MainSettingPageState();
}

class _MainSettingPageState extends State<MainSettingPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('설정'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoListSection(
              header: const Text('계정'),
              children: <CupertinoListTile>[
                CupertinoListTile(
                  title: const Text('로그아웃'),
                  leading: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: CupertinoColors.activeGreen,
                  ),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () {
                    userProvider.setSignIn(false);
                  },
                ),
                // CupertinoListTile(
                //   title: const Text('Push to master'),
                //   leading: Container(
                //     width: double.infinity,
                //     height: double.infinity,
                //     color: CupertinoColors.systemRed,
                //   ),
                //   additionalInfo: const Text('Not available'),
                // ),
                CupertinoListTile(
                  title: const Text('개인정보 수정하기'),
                  leading: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: CupertinoColors.activeOrange,
                  ),
                  
                  trailing: const CupertinoListTileChevron(),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InputInfoPage1()),
                    );
                    print("mainsetting");
                    await userProvider.getMe();
                    await userProvider.getUsers();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
