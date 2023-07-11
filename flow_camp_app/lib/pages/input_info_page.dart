import 'package:flow_camp_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flow_camp_app/constants/urls.dart';
import 'package:provider/provider.dart';

class CheckboxItem {
  String title;
  bool checked;

  CheckboxItem({required this.title, this.checked = false});
}

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  List<CheckboxItem> checkboxList = [
    CheckboxItem(title: 'Item 1', checked: false),
    CheckboxItem(title: 'Item 2', checked: false),
  ];

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _getInterestList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    Future<void> _getInterestList() async {
    userProvider.getInterest(context);
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
          body: Center(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          height: 16,
                          child: const Text(
                            "Interests",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: ListView.builder(
                            itemCount: checkboxList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CheckboxListTile(
                                title: Text(checkboxList[index].title),
                                value: checkboxList[index].checked,
                                onChanged: (value) {
                                  setState(() {
                                    checkboxList[index].checked = value!;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 50,
                        ),
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
                      ],
                    ),
                  ),
                )),
          ),
        )),
      ),
    );
  }
}

class InputInfoPage extends StatefulWidget {
  const InputInfoPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<InputInfoPage> createState() => _InputInfoPageState();
}

class _InputInfoPageState extends State<InputInfoPage> {
  // int _counter = 0;
  bool _isLoading = false;
  late TextEditingController _nameController,
      _univController,
      _interestController,
      _yearController,
      _sidController,
      _classController;
  late FocusNode _nameFocusNode,
      _univFocusNode,
      _interestFocusNode,
      _yearFocusNode,
      _sidFocusNode,
      _classFocusNode;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _univController = TextEditingController();
    _interestController = TextEditingController();
    _yearController = TextEditingController();
    _sidController = TextEditingController();
    _classController = TextEditingController();

    _nameFocusNode = FocusNode();
    _univFocusNode = FocusNode();
    _interestFocusNode = FocusNode();
    _yearFocusNode = FocusNode();
    _sidFocusNode = FocusNode();
    _classFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _univController.dispose();
    _interestController.dispose();
    _yearController.dispose();
    _sidController.dispose();
    _classController.dispose();

    _nameFocusNode.dispose();
    _univFocusNode.dispose();
    _interestFocusNode.dispose();
    _yearFocusNode.dispose();
    _sidFocusNode.dispose();
    _classFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("회원정보(1/2)"),
        ),
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: Image.asset("assets/images/flowlinkLogo.png"),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 50,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 16,
                          child: const Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: CupertinoTextField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            textInputAction: TextInputAction.next,
                            padding: const EdgeInsets.only(left: 10),
                            textAlignVertical: TextAlignVertical.center,
                            placeholder: "이름",
                            placeholderStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: Colors.grey),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blue,
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 10,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 16,
                          child: const Text(
                            "University",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: CupertinoTextField(
                            controller: _univController,
                            focusNode: _univFocusNode,
                            textInputAction: TextInputAction.next,
                            padding: const EdgeInsets.only(left: 10),
                            textAlignVertical: TextAlignVertical.center,
                            placeholder: "대학교",
                            placeholderStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: Colors.grey),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blue,
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 10,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 16,
                          child: const Text(
                            "Year",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: CupertinoTextField(
                            controller: _yearController,
                            focusNode: _yearFocusNode,
                            textInputAction: TextInputAction.next,
                            padding: const EdgeInsets.only(left: 10),
                            textAlignVertical: TextAlignVertical.center,
                            placeholder: "분기",
                            placeholderStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: Colors.grey),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blue,
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 10,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 16,
                          child: const Text(
                            "Student ID",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: CupertinoTextField(
                            controller: _sidController,
                            focusNode: _sidFocusNode,
                            textInputAction: TextInputAction.next,
                            padding: const EdgeInsets.only(left: 10),
                            textAlignVertical: TextAlignVertical.center,
                            placeholder: "KAIST 학번",
                            placeholderStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: Colors.grey),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blue,
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 10,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 16,
                          child: const Text(
                            "Class",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: CupertinoTextField(
                            controller: _classController,
                            focusNode: _classFocusNode,
                            textInputAction: TextInputAction.next,
                            padding: const EdgeInsets.only(left: 10),
                            textAlignVertical: TextAlignVertical.center,
                            placeholder: "분반",
                            placeholderStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: Colors.grey),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blue,
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 10,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: CupertinoButton.filled(
                              padding: const EdgeInsets.all(0),
                              child: const Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InterestPage()));
                              }),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        )),
      ),
    );
  }
}
