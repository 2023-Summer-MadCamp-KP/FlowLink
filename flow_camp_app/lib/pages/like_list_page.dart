import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flow_camp_app/providers/user_provider.dart';
import 'package:flow_camp_app/models/user.dart';
import 'package:flow_camp_app/models/interest.dart';
import 'package:flow_camp_app/components/loading_indicator_page.dart';
import 'package:flow_camp_app/pages/profile_view_page.dart';
import 'package:flow_camp_app/pages/profile_list_page.dart';

class LikeListPage extends StatefulWidget {
  const LikeListPage({Key? key}) : super(key: key);

  @override
  State<LikeListPage> createState() => _LikeListPageState();
}

// class Person {
//   late String name;
//   late Image profileImage;
//   late bool like;
//   late List<String> categoryList;

//   Person(this.name, Image? profileImage, this.like, this.categoryList) {
//     this.profileImage =
//         profileImage ?? Image.asset("assets/images/googleIcon.png");
//   }
// }

// class Person extends User {
//   var profileImage;

//   var islike;

//   Person({
//     required int id,
//     required String name,
//     required int gradOf,
//     required String uid,
//     required String password,
//     required String platform,
//     required int prtcpntYear,
//     required bool emailConfirmed,
//     required bool infoConfirmed,
//     required this.profileImage,
//     required this.islike,
//   }) : super(
//           id: id,
//           name: name,
//           gradOf: gradOf,
//           uid: uid,
//           password: password,
//           platform: platform,
//           prtcpntYear: prtcpntYear,
//           emailConfirmed: emailConfirmed,
//           infoConfirmed: infoConfirmed,
//         );
// }

class _LikeListPageState extends State<LikeListPage> {
  final List<String> category = <String>[
    "App",
    "Web",
    "AI",
    "Game",
    "VR",
    "Blockchain"
  ];
  // List<Person> people = <Person>[
  //   Person("아무개", null, false, []),
  //   Person("나나나", Image.asset("assets/images/flowlinkLogo.png"), false,
  //       ["App", "Web"]),
  //   Person("시나모롤", Image.asset("assets/images/roll.jpg"), true,
  //       ["Web", "AI", "Game"])
  // ];
  List<Person> peopleLikeTo = [];
  List<Person> peopleLikeFrom = [];
  List<Person> peopleLikeBoth = [];

  late List<Person> peopleShow = [];

  int _likeFilter = 0;
  List<String> _likeFilterText = ["나를 좋아해", "내가 좋아해", "서로 좋아해"];
  List<String> _categoryFilter = [];

  String searchQuery = '';

  // late TextEditingController _searchController;

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _searchController = TextEditingController();
    api();
  }

  @override
  void dispose() {
    // _searchController.dispose();
    super.dispose();
  }

  void api() async {
    setState(() {
      _isLoading = true;
    });
    var provider = context.read<UserProvider>();
    await provider.getMe();
    await provider.getUsers();
    await provider.getLike();
    await provider.getWhoLike();
    setState(() {
      _isLoading = false;
    });
  }

  void _showLike(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      setState(() {
                        _likeFilter = 0;
                      });
                      _close(_);
                    },
                    child: const Text("나를 좋아해")),
                CupertinoActionSheetAction(
                    onPressed: () {
                      setState(() {
                        _likeFilter = 1;
                      });
                      _close(_);
                    },
                    child: const Text("내가 좋아해")),
                CupertinoActionSheetAction(
                    onPressed: () {
                      setState(() {
                        _likeFilter = 2;
                      });
                      _close(_);
                    },
                    child: const Text("서로 좋아해")),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => _close(_),
                child: const Text('닫기'),
              ),
            ));
  }

  void _showCategory(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => StatefulBuilder(
              builder: ((context, setCategoryState) => CupertinoActionSheet(
                    actions: [
                      CupertinoActionSheetAction(
                          onPressed: () {
                            setState(() {
                              setCategoryState(
                                () => _categoryFilter.contains(category[0])
                                    ? _categoryFilter.remove(category[0])
                                    : _categoryFilter.add(category[0]),
                              );
                            });
                          },
                          child: Text(
                            "App",
                            style: TextStyle(
                              color: _categoryFilter.contains(category[0])
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          )),
                      CupertinoActionSheetAction(
                          onPressed: () {
                            setState(() {
                              setCategoryState(() =>
                                  _categoryFilter.contains(category[1])
                                      ? _categoryFilter.remove(category[1])
                                      : _categoryFilter.add(category[1]));
                            });
                          },
                          child: Text(
                            "Web",
                            style: TextStyle(
                              color: _categoryFilter.contains(category[1])
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          )),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () => _close(_),
                      child: const Text('Close'),
                    ),
                  )),
            ));
  }

  void _close(BuildContext ctx) {
    Navigator.of(ctx).pop();
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

    List<Person> peopleShowCopy = [];

    Set<int> likeToValues =
        provider.takeLikes.map((like) => like.likeFrom).toSet();

    Set<int> likeFromValues =
        provider.giveLikes.map((like) => like.likeTo).toSet();
    Set<int> likeBothValues = {};
    for (int element in likeToValues) {
      if (likeFromValues.contains(element)) {
        likeBothValues.add(element);
      }
    }
    peopleLikeTo = provider.users
        .map(
          (user) {
            var ii = true;
            if (likeToValues.contains(user.id)) {
              ii = true;
            } else {
              ii = false;
            }
            if (ii) {
              return Person(
                user: user,
                profileImage: 'assets/images/default_profile.png',
                doILike: ii,
              );
            } else {
              return null; // Nullable한 Person 객체는 null로 반환
            }
          },
        )
        .whereType<Person>() // null이 아닌 Person 객체들만 필터링
        .toList();
    peopleLikeTo.sort((a, b) {
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

    peopleLikeFrom = provider.users
        .map(
          (user) {
            var ii = true;
            if (likeFromValues.contains(user.id)) {
              ii = true;
            } else {
              ii = false;
            }
            if (ii) {
              return Person(
                user: user,
                profileImage: 'assets/images/default_profile.png',
                doILike: ii,
              );
            } else {
              return null; // Nullable한 Person 객체는 null로 반환
            }
          },
        )
        .whereType<Person>() // null이 아닌 Person 객체들만 필터링
        .toList();
    peopleLikeFrom.sort((a, b) {
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

    peopleLikeBoth = provider.users
        .map(
          (user) {
            var ii = true;
            if (likeBothValues.contains(user.id)) {
              ii = true;
            } else {
              ii = false;
            }
            if (ii) {
              return Person(
                user: user,
                profileImage: 'assets/images/default_profile.png',
                doILike: ii,
              );
            } else {
              return null; // Nullable한 Person 객체는 null로 반환
            }
          },
        )
        .whereType<Person>() // null이 아닌 Person 객체들만 필터링
        .toList();
    peopleLikeBoth.sort((a, b) {
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

    if (_likeFilter == 0) {
      peopleShow = peopleLikeTo;
    } else if (_likeFilter == 1) {
      peopleShow = peopleLikeFrom;
    } else {
      peopleShow = peopleLikeBoth;
    }

    for (Person person in peopleShow) {
      if (person.name.contains(searchQuery)) {
        print(searchQuery);
        print(person.name);
        peopleShowCopy.add(person);
      }
    }

    peopleShow = List.from(peopleShowCopy);

    String getInterestString(int index) {
      String interestString = "";
      Person person = peopleShow[index];
      if (person.interests != null) {
        for (Interest interest in person.interests!) {
          if (interestString == "") {
            interestString = interest.name;
          } else {
            interestString = interestString + " / " + interest.name;
          }
        }
      }

      return interestString;
    }

    // peopleShow = List.from(peopleShowCopy);

    // if (_likeFilter) {
    //   peopleShow.clear();
    //   for (int i = 0; i < people.length; i++) {
    //     if (people[i].like) {
    //       peopleShow.add(people[i]);
    //     }
    //   }
    // } else {
    //   peopleShow = List.from(people);
    // }

    // for (int i = peopleShow.length - 1; i >= 0; i--) {
    //   bool contain = true;
    //   for (int j = 0; j < _categoryFilter.length; j++) {
    //     contain =
    //         contain & peopleShow[i].categoryList.contains(_categoryFilter[j]);
    //   }
    //   if (!contain) {
    //     peopleShow.removeAt(i);
    //   }
    // }

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: CupertinoSearchTextField(
                      // controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                          print(searchQuery);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CupertinoButton(
                      child: Text(
                        _likeFilterText[_likeFilter],
                        style: TextStyle(fontSize: 17),
                      ),
                      onPressed: () => _showLike(context),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CupertinoButton(
                      child: Text("필터"),
                      onPressed: () => _showCategory(context),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: peopleShow.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // 탭 이벤트 처리
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfileViewPage(user: peopleShow[index])));
                      },
                      child: Container(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: CupertinoListTile(
                              backgroundColor: Colors.grey[50],
                              leadingSize: 40,
                              title: Text(peopleShow[index].name,
                                  style: const TextStyle(
                                      decoration: TextDecoration.none)),
                              subtitle: Text(getInterestString(index),
                                  style: TextStyle(
                                      decoration: TextDecoration.none)),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:
                                    Image.asset(peopleShow[index].profileImage),
                              ),
                            )),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
