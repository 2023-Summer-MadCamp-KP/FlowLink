import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LikeListPage extends StatefulWidget {
  const LikeListPage({Key? key}) : super(key: key);

  @override
  State<LikeListPage> createState() => _LikeListPageState();
}

class Person {
  late String name;
  late Image profileImage;
  late bool like;
  late List<String> categoryList;

  Person(this.name, Image? profileImage, this.like, this.categoryList) {
    this.profileImage =
        profileImage ?? Image.asset("assets/images/googleIcon.png");
  }
}

class _LikeListPageState extends State<LikeListPage> {
  final List<String> category = <String>[
    "App",
    "Web",
    "AI",
    "Game",
    "VR",
    "Blockchain"
  ];
  final List<Person> people = <Person>[
    Person("아무개", null, false, []),
    Person("나나나", Image.asset("assets/images/flowlinkLogo.png"), false,
        ["App", "Web"]),
    Person("시나모롤", Image.asset("assets/images/roll.jpg"), true,
        ["Web", "AI", "Game"])
  ];

  late List<Person> peopleShow = [];

  bool _likeFilter = false;
  List<String> _categoryFilter = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _showLike(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      setState(() {
                        _likeFilter = false;
                      });
                      _close(_);
                    },
                    child: const Text("전체")),
                CupertinoActionSheetAction(
                    onPressed: () {
                      setState(() {
                        _likeFilter = true;
                      });
                      _close(_);
                    },
                    child: const Text("like")),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => _close(_),
                child: const Text('Close'),
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
    if (_likeFilter) {
      peopleShow.clear();
      for (int i = 0; i < people.length; i++) {
        if (people[i].like) {
          peopleShow.add(people[i]);
        }
      }
    } else {
      peopleShow = List.from(people);
    }

    for (int i = peopleShow.length - 1; i >= 0; i--) {
      bool contain = true;
      for (int j = 0; j < _categoryFilter.length; j++) {
        contain =
            contain & peopleShow[i].categoryList.contains(_categoryFilter[j]);
      }
      if (!contain) {
        peopleShow.removeAt(i);
      }
    }
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CupertinoSearchTextField(),
                  ),
                  Expanded(
                    flex: 1,
                    child: CupertinoButton(
                      child: Text(_likeFilter ? "like" : "전체"),
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
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: CupertinoListTile(
                          leadingSize: 40,
                          title: Text(peopleShow[index].name,
                              style: const TextStyle(
                                  decoration: TextDecoration.none)),
                          // subtitle: Text("${entries[index]}",
                          //   style: TextStyle(decoration: TextDecoration.none)
                          // ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: peopleShow[index].profileImage,
                          ),
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
