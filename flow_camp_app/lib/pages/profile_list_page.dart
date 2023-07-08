import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileListPage extends StatefulWidget {
  const ProfileListPage({Key? key}) : super(key: key);

  @override
  State<ProfileListPage> createState() => _ProfileListPageState();
}

class Person {
  final String name;
  final String profileImage;

  Person({required this.name, required this.profileImage});
}

class _ProfileListPageState extends State<ProfileListPage> {
  final List<Person> persons = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    persons.addAll([
      Person(name: '김현수', profileImage: 'assets/images/default_profile.png'),
      Person(name: '오지환', profileImage: 'assets/images/default_profile.png'),
      Person(name: '박근영', profileImage: 'assets/images/default_profile.png'),
      Person(name: '김현수', profileImage: 'assets/images/googleIcon.png'),
      Person(name: '오지환', profileImage: 'assets/images/default_profile.png'),
      Person(name: '박근영', profileImage: 'assets/images/default_profile.png'),
      Person(name: '김현수', profileImage: 'assets/images/googleIcon.png'),
      Person(name: '오지환', profileImage: 'assets/images/default_profile.png'),
      Person(name: '박근영', profileImage: 'assets/images/default_profile.png'),
      Person(name: '김현수', profileImage: 'assets/images/googleIcon.png'),
      Person(name: '오지환', profileImage: 'assets/images/default_profile.png'),
      Person(name: '박근영', profileImage: 'assets/images/default_profile.png'),
      Person(name: '김현수', profileImage: 'assets/images/googleIcon.png'),
      Person(name: '오지환', profileImage: 'assets/images/default_profile.png'),
      Person(name: '박근영', profileImage: 'assets/images/default_profile.png'),
      Person(name: '김현수', profileImage: 'assets/images/googleIcon.png'),
      Person(name: '오지환', profileImage: 'assets/images/default_profile.png'),
      Person(name: '박근영', profileImage: 'assets/images/default_profile.png'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
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
