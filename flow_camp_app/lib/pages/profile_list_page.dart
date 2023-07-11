import 'package:flow_camp_app/models/user.dart';
import 'package:flow_camp_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flow_camp_app/pages/profile_view_page.dart';

class ProfileListPage extends StatefulWidget {
  const ProfileListPage({Key? key}) : super(key: key);

  @override
  State<ProfileListPage> createState() => _ProfileListPageState();
}

class Person extends User {
  var profileImage;

  var islike;

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
    required this.islike,
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
    await provider.getMe();
    await provider.getUsers();
    await provider.getLike();
    print(provider.me.toJson());
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<UserProvider>();
    print("change notify");
    var my = Person(
      id: provider.me.id,
      name: provider.me.name,
      gradOf: provider.me.gradOf,
      uid: provider.me.uid,
      password: provider.me.password,
      platform: provider.me.platform,
      prtcpntYear: provider.me.prtcpntYear,
      emailConfirmed: provider.me.emailConfirmed,
      infoConfirmed: provider.me.infoConfirmed,
      profileImage: 'assets/images/default_profile.png',
      islike: false, // Add your images here
    );
    Set<int> likeFromValues =
        provider.giveLikes.map((like) => like.likeTo).toSet();
    print("ll : " + likeFromValues.toString());
    persons = provider.users.map(
      (user) {
        var ii = true;
        if (likeFromValues.contains(user.id)) {
          ii = true;
        } else {
          ii = false;
        }
        return Person(
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
            islike: ii);
      },
    ).toList();

    print(provider.me.id);
    persons.sort((a, b) {
      if (a.id != my.id && b.id == my.id) {
        return 1;
      } else if (a.prtcpntYear == my.prtcpntYear &&
          b.prtcpntYear != my.prtcpntYear) {
        return -1;
      } else if (a.prtcpntYear != my.prtcpntYear &&
          b.prtcpntYear == my.prtcpntYear) {
        return 1;
      } else {
        return b.prtcpntYear.compareTo(a.prtcpntYear);
      }
    });

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
                        leading: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage(persons[index].profileImage),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileViewPage(user: persons[index])));
                          },
                        ),
                        title: Text(persons[index].name,
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text(persons[index].prtcpntYear.toString()),
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
                        leading: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage(persons[index].profileImage),
                          ),
                          onPressed: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileViewPage(user: persons[index])));},
                        ),
                        title: Text(persons[index].name,
                            style: TextStyle(fontSize: 15)),
                        subtitle: Text(persons[index].prtcpntYear.toString()),
                        trailing: GestureDetector(
                          onTap: () async {
                            await provider.postLike(
                                persons[index].id, !persons[index].islike);
                            await provider.getLike();
                          },
                          child: Icon(
                            Icons.favorite,
                            size: 40,
                            color: persons[index].islike
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
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
