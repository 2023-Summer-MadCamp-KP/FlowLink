import 'package:flow_camp_app/models/user.dart';
import 'package:flow_camp_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileListPage extends StatefulWidget {
  const ProfileListPage({Key? key}) : super(key: key);

  @override
  State<ProfileListPage> createState() => _ProfileListPageState();
}

class Person extends User {
  String profileImage;

  Person({
    required int id,
    required String name,
    required int gradOf,
    required String uid,
    required String password,
    required String platform,
    required int prtcpntYear,
    required bool emailConfirmed,
    required bool infoConfirmed,
    required this.profileImage,
  }) : super(
          id: id,
          name: name,
          gradOf: gradOf,
          uid: uid,
          password: password,
          platform: platform,
          prtcpntYear: prtcpntYear,
          emailConfirmed: emailConfirmed,
          infoConfirmed: infoConfirmed,
        );
}

class _ProfileListPageState extends State<ProfileListPage> {
  List<Person> persons = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    api();
  }

  void api() async {
    var provider = context.read<UserProvider>();
    await provider.apiMe();
    await provider.apiUsers();
    print(provider.me.toJson());
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<UserProvider>();
    print("change notify");
    persons = provider.users
        .map(
          (user) => Person(
            id: user.id,
            name: user.name,
            gradOf: user.gradOf,
            uid: user.uid,
            password: user.password,
            platform: user.platform,
            prtcpntYear: user.prtcpntYear,
            emailConfirmed: user.emailConfirmed,
            infoConfirmed: user.infoConfirmed,
            profileImage:
                'assets/images/default_profile.png', // Add your images here
          ),
        )
        .toList();
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('프로필'),
          trailing: Icon(CupertinoIcons.search),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () {
                    // 탭 이벤트 처리
                    print('Tapped ${persons[index].name}');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: CupertinoColors.separator,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        10,
                        0,
                        10,
                      ),
                      child: CupertinoListTile(
                        leadingSize: 60,
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage(persons[index].profileImage),
                        ),
                        title: Text(persons[index].name,
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text(persons[index].name),
                      ),
                    ),
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    // 탭 이벤트 처리
                    print('Tapped ${persons[index].name}');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          // bottom: BorderSide(
                          //   color: CupertinoColors.separator,
                          //   width: 0.5,
                          // ),
                          ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        10,
                        0,
                        10,
                      ),
                      child: CupertinoListTile(
                        leadingSize: 50,
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage(persons[index].profileImage),
                        ),
                        title: Text(persons[index].name,
                            style: TextStyle(fontSize: 15)),
                        subtitle: Text(persons[index].name),
                      ),
                    ),
                  ),
                );
              }
            },
            itemCount: persons.length,
          ),
        ));
  }
}
