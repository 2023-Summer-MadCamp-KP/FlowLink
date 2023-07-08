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
  final List<Person> people = <Person>[Person("아무개", null), Person("나나나", Image.asset("images/flowlinkLogo.png")), Person("시나모롤", Image.asset("images/roll.jpg"))];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: CupertinoSearchTextField(),
      ),
      child: SafeArea(
        child: ListView.builder(
            itemCount: people.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: CupertinoListTile(
                    leadingSize: 40,
                    title: Text(people[index].name,
                        style: const TextStyle(decoration: TextDecoration.none)),
                    // subtitle: Text("${entries[index]}",
                    //   style: TextStyle(decoration: TextDecoration.none)
                    // ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: people[index].profileImage,
                    ),
                  ));
            }),
      ),
    );
  }
}
