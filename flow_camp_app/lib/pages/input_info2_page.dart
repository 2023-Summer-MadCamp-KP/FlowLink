import 'package:flow_camp_app/components/loading_indicator_page.dart';
import 'package:flow_camp_app/models/interest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class CheckboxItem {
  String title;
  bool checked;

  CheckboxItem({required this.title, this.checked = false});
}

class SelectableInterest extends Interest {
  bool isSelected;

  SelectableInterest(
      {required String name,
      required String category,
      required bool confirmed,
      bool isSelected = false})
      : this.isSelected = isSelected,
        super(
            name: name,
            category: category,
            confirmed: confirmed); // Call the super constructor
}

class InputInfoPage2 extends StatefulWidget {
  const InputInfoPage2({super.key});

  @override
  State<InputInfoPage2> createState() => _InputInfoPage2State();
}

class _InputInfoPage2State extends State<InputInfoPage2> {
  Map<String, List<SelectableInterest>> categorizedInterests = {};
  List<SelectableInterest> interests = [];
  bool _isLoading = true;
  List<CheckboxItem> checkboxList = [
    CheckboxItem(title: 'Item 1', checked: false),
    CheckboxItem(title: 'Item 2', checked: false),
  ];

  @override
  void initState() {
    super.initState();
    apiInit();
  }

  void apiInit() async {
    setState(() {
      _isLoading = true;
    });
    var provider = context.read<UserProvider>();
    provider.getInterest();

    interests = provider.allInterests.map((interest) {
      return SelectableInterest(
          name: interest.name,
          category: interest.category,
          confirmed: interest.confirmed,
          isSelected: false,
          );
    }).toList();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return LoadingIndicator();
    UserProvider userProvider = context.watch<UserProvider>();

    
    categorizedInterests = {};
    for (var interest in interests) {
      if (categorizedInterests.containsKey(interest.category)) {
        categorizedInterests[interest.category]!.add(interest);
      } else {
        categorizedInterests[interest.category] = [interest];
      }
    }

    Future<void> _getInterestList() async {
      userProvider.getInterest();
      return;
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("회원정보(2/2)"),
        ),
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.white,
          body: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 00, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: Image.asset("assets/images/flowlinkLogo.png"),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: const Text(
                          "관심사를 선택하세요",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      ...categorizedInterests.keys.toList().map((key) {
                        return CupertinoListSection(
                          header: Text(key),
                          children: categorizedInterests[key]!
                              .map((interest) => CupertinoListTile(
                                    title: Text(interest.name),
                                    leading: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      color:  interest.isSelected ? CupertinoColors.activeGreen:CupertinoColors.systemGrey,
                                    ),
                                    trailing: const CupertinoListTileChevron(),
                                    onTap: () {
                                      setState(() {
                                        interest.isSelected =
                                            !interest.isSelected;
                                      });

                                      // 여기에 타일이 탭될 때 수행할 작업을 추가하세요.
                                    },
                                  ))
                              .toList(),
                        );
                      }).toList(),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: CupertinoButton.filled(
                          padding: const EdgeInsets.all(0),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          onPressed: _getInterestList,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
          ),
        )),
      ),
    );
  }
}
