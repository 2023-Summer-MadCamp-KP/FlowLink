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

  Person(this.name, Image? profileImage) {
    this.profileImage = profileImage ?? Image.asset("images/googleIcon.png");
  }
}

class _LikeListPageState extends State<LikeListPage> {
  final List<Person> people = <Person>[
    Person("아무개", null),
    Person("나나나", Image.asset("images/flowlinkLogo.png")),
    Person("시나모롤", Image.asset("images/roll.jpg"))
  ];

  final List<Person> peopleMutualLike = <Person>[
    Person("시나모롤", Image.asset("images/roll.jpg"))
  ];

  late List<Person> peopleShow;

  bool _likeFilter = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _show(BuildContext ctx) {
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

  void _close(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    peopleShow = _likeFilter ? peopleMutualLike : people;
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
                      onPressed: () => _show(context),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CupertinoButton(
                      child: Text("전체"),
                      onPressed: (){},
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
