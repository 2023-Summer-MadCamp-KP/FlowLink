import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LikeListPage extends StatefulWidget {
  const LikeListPage({Key? key}) : super(key: key);

  @override
  State<LikeListPage> createState() => _LikeListPageState();
}

class _LikeListPageState extends State<LikeListPage> {
  final List<String> entries = <String>[
    "A",
    "B",
    "C",
    "B",
    "C",
    "B",
    "C",
    "B",
    "C",
    "B",
    "C",
    "B",
    "C",
    "B",
    "C",
    "B",
    "C",
    "B",
    "C"
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSearchTextField(),
      ),
      child: SafeArea(
        child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: CupertinoListTile(
                  leadingSize: 50,
                  title: Text("${entries[index]}",
                    style: TextStyle(decoration: TextDecoration.none)
                  ),
                  // subtitle: Text("${entries[index]}",
                  //   style: TextStyle(decoration: TextDecoration.none)
                  // ),
                  leading: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
