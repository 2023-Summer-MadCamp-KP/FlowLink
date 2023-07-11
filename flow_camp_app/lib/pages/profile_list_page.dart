import 'package:flow_camp_app/components/loading_indicator_page.dart';
import 'package:flow_camp_app/models/interest.dart';
import 'package:flow_camp_app/models/university.dart';
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

  var doILike;

  Person({
    required User user,
    required this.profileImage,
    required this.doILike,
  }) : super(
          id: user.id,
          name: user.name,
          gradOf: user.gradOf,
          token: user.token,
          uid: user.uid,
          password: user.password,
          platform: user.platform,
          prtcpntYear: user.prtcpntYear,
          emailConfirmed: user.emailConfirmed,
          infoConfirmed: user.infoConfirmed,
          university: user.university,
          interests: user.interests,
        );
}

class _ProfileListPageState extends State<ProfileListPage> {
  List<Person> persons = [];

  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    api();
  }

  void api() async {
    setState(() {
      _isLoading = true;
    });
    var provider = context.read<UserProvider>();
    await provider.getMe();
    await provider.getUsers();
    await provider.getLike();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<UserProvider>();
    if (_isLoading || provider.me == null) {
      return LoadingIndicator();
    }
    var my = Person(
      user: provider.me!,
      profileImage: 'assets/images/default_profile.png',
      doILike: false, // Add your images here
    );
    Set<int> likeFromValues =
        provider.giveLikes.map((like) => like.likeTo).toSet();
    persons = provider.users.map(
      (user) {
        var _isLike = true;
        if (likeFromValues.contains(user.id)) {
          _isLike = true;
        } else {
          _isLike = false;
        }
        return Person(
            user: user,
            profileImage:
                'assets/images/default_profile.png', // Add your images here
            doILike: _isLike);
      },
    ).toList();
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileViewPage(user: persons[index])));
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
                          onPressed: () {},
                        ),
                        title: Text(persons[index].name,
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text(persons[index].prtcpntYear.toString()),
                      ),
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // 탭 이벤트 처리
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfileViewPage(user: persons[index])));
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
                            subtitle:
                                Text(persons[index].prtcpntYear.toString()),
                            trailing: GestureDetector(
                              onTap: () async {
                                await provider.postLike(
                                    persons[index].id, !persons[index].doILike);
                                await provider.getLike();
                              },
                              child: Icon(
                                Icons.favorite,
                                size: 40,
                                color: persons[index].doILike
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
            itemCount: persons.length,
          ),
        ));
  }
}
