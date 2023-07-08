import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainSettingPage extends StatefulWidget {
  const MainSettingPage({Key? key}) : super(key: key);

  @override
  State<MainSettingPage> createState() => _MainSettingPageState();
}

class _MainSettingPageState extends State<MainSettingPage> {
  @override
  Widget build(BuildContext context) {
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
                    onTap: () => {}),
                CupertinoListTile(
                  title: const Text('Push to master'),
                  leading: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: CupertinoColors.systemRed,
                  ),
                  additionalInfo: const Text('Not available'),
                ),
                CupertinoListTile(
                  title: const Text('View last commit'),
                  leading: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: CupertinoColors.activeOrange,
                  ),
                  additionalInfo: const Text('12 days ago'),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
