import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flow_camp_app/pages/profile_list_page.dart';

class ProfileViewPage extends StatefulWidget {
  final Person user;
  const ProfileViewPage({required this.user, super.key});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  @override
  Widget build(BuildContext context) {
    const double textMargin = 10;
    const double boxMargin = 30;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("프로필 상세정보"),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage:
                        AssetImage(widget.user.profileImage), // 프로필 사진 이미지
                  ),
                  SizedBox(height: 10.0),
                  DefaultTextStyle(
                    child: Text(widget.user.name), // 유저 이름
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    child: Text("대학"), // 유저 이름
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: textMargin,
                  ),
                  DefaultTextStyle(
                    child: Text("KAIST"), // 유저 이름
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: boxMargin,
                  ),
                  DefaultTextStyle(
                    child: Text("학번"), // 유저 이름
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: textMargin,
                  ),
                  DefaultTextStyle(
                    child: Text("KAIST"), // 유저 이름
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: boxMargin,
                  ),
                  DefaultTextStyle(
                    child: Text("분기"), // 유저 이름
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: textMargin,
                  ),
                  DefaultTextStyle(
                    child: Text("KAIST"), // 유저 이름
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: boxMargin,
                  ),
                  DefaultTextStyle(
                    child: Text("흥미"), // 유저 이름
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: textMargin,
                  ),
                  DefaultTextStyle(
                    child: Text("KAIST"), // 유저 이름
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: boxMargin,
                  ),
                  DefaultTextStyle(
                    child: Text("분반"), // 유저 이름
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: textMargin,
                  ),
                  DefaultTextStyle(
                    child: Text("KAIST"), // 유저 이름
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: boxMargin,
                  ),
                  DefaultTextStyle(
                    child: Text("전공"), // 유저 이름
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: textMargin,
                  ),
                  DefaultTextStyle(
                    child: Text("KAIST"), // 유저 이름
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
