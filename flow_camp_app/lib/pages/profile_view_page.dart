import 'package:flow_camp_app/pages/profile_list_page.dart';
import 'package:flow_camp_app/utils/decode_prtc_year.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
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
                    ),
                    const SizedBox(height: 20.0),
                    Column(
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
                          child: Text(widget.user.university.name), // 유저 이름
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
                          child: Text(
                            widget.user.gradOf.toString(),
                          ), // 유저 이름
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
                          child: Text(decodePrtcYear(widget.user.prtcpntYear)[0].toString()+"년 / "+decodePrtcYear(widget.user.prtcpntYear)[1].toString()), // 유저 이름
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
                          child: Text("Kgm"), // 유저 이름
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
                          child: Text(decodePrtcYear(widget.user.gradOf)[2].toString()), // 유저 이름
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
                          child: Text("전고"), // 유저 이름
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
          ),
        ),
      ),
    );
  }
}
