import 'package:flow_camp_app/components/loading_indicator_page.dart';
import 'package:flow_camp_app/pages/input_info2_page.dart';
import 'package:flow_camp_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flow_camp_app/constants/urls.dart';
import 'package:provider/provider.dart';
import 'package:flow_camp_app/models/user_info.dart';

class InputInfoPage1 extends StatefulWidget {
  const InputInfoPage1({super.key});

  @override
  State<InputInfoPage1> createState() => _InputInfoPage1State();
}

class _InputInfoPage1State extends State<InputInfoPage1> {
  // int _counter = 0;
  bool _isLoading = false;
  var _universities = [];
  final Map<String, int> _seasonMap = {"봄": 1, "여름": 2, "가을": 3, "겨울": 4};

  late TextEditingController _nameController,
      _univController,
      _interestController,
      _yearController,
      _sidController,
      _classController,
      _seasonController;
  late FocusNode _nameFocusNode,
      _univFocusNode,
      _interestFocusNode,
      _yearFocusNode,
      _sidFocusNode,
      _classFocusNode,
      _seasonFocusNode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _univController = TextEditingController();
    _interestController = TextEditingController();
    _yearController = TextEditingController();
    _sidController = TextEditingController();
    _classController = TextEditingController();
    _seasonController = TextEditingController();

    _nameFocusNode = FocusNode();
    _univFocusNode = FocusNode();
    _interestFocusNode = FocusNode();
    _yearFocusNode = FocusNode();
    _sidFocusNode = FocusNode();
    _classFocusNode = FocusNode();
    _seasonFocusNode = FocusNode();

    apiInit();
  }

  void apiInit() async {
    setState(() {
      _isLoading = true;
    });
    var userProvider = context.read<UserProvider>();
    await userProvider.getUniversity();
    _universities = userProvider.allUniversity;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _univController.dispose();
    _interestController.dispose();
    _yearController.dispose();
    _sidController.dispose();
    _classController.dispose();
    _seasonController.dispose();

    _nameFocusNode.dispose();
    _univFocusNode.dispose();
    _interestFocusNode.dispose();
    _yearFocusNode.dispose();
    _sidFocusNode.dispose();
    _classFocusNode.dispose();
    _seasonFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LoadingIndicator();
    }
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
                            readOnly: true,
                            onTap: () {
                              setState(() {
                                _univController.text =
                                    _universities[0].name.toString();
                              });
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoActionSheet(
                                    title: Text('Select University'),
                                    message:
                                        Text('Please select a university.'),
                                    actions: <Widget>[
                                      Container(
                                        height: 200,
                                        child: CupertinoPicker(
                                          looping: false,
                                          itemExtent: 30,
                                          onSelectedItemChanged: (index) {
                                            setState(() {
                                              _univController.text =
                                                  _universities[index]
                                                      .name
                                                      .toString();
                                            });
                                          },
                                          children: List<Widget>.generate(
                                              _universities.length, (index) {
                                            return Text(
                                                '${_universities[index].name}');
                                          }),
                                        ),
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: Text('Done'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            padding: const EdgeInsets.only(left: 10),
                            textAlignVertical: TextAlignVertical.center,
                            placeholder: "연도",
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
                            "Season",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: CupertinoTextField(
                            onTap: () {
                              setState(() {
                                _seasonController.text = "봄";
                              });
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoActionSheet(
                                    title: Text('분기를 선택하세요'),
                                    message: Text('분기를 선택'),
                                    actions: <Widget>[
                                      Container(
                                        height: 200,
                                        child: CupertinoPicker(
                                          looping: false,
                                          itemExtent: 30,
                                          onSelectedItemChanged: (index) {
                                            setState(() {
                                              _seasonController.text = '${[
                                                '봄',
                                                '여름',
                                                '가을',
                                                '겨울'
                                              ][index]}';
                                            });
                                          },
                                          children:
                                              List<Widget>.generate(4, (index) {
                                            return Text('${[
                                              '봄',
                                              '여름',
                                              '가을',
                                              '겨울'
                                            ][index]}');
                                          }),
                                        ),
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: Text('Done'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            readOnly: true,
                            controller: _seasonController,
                            focusNode: _seasonFocusNode,
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
                            onTap: () {
                              setState(() {
                                _classController.text = '1';
                              });
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoActionSheet(
                                    title: Text('분반을 선택하세요'),
                                    message: Text('분반을 선택'),
                                    actions: <Widget>[
                                      Container(
                                        height: 200,
                                        child: CupertinoPicker(
                                          looping: false,
                                          itemExtent: 30,
                                          onSelectedItemChanged: (index) {
                                            setState(() {
                                              _classController.text =
                                                  '${index + 1}';
                                            });
                                          },
                                          children:
                                              List<Widget>.generate(4, (index) {
                                            return Text('${index + 1}');
                                          }),
                                        ),
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: Text('Done'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            readOnly: true,
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
                              onPressed: () async {
                                int getUniversityId(university) {
                                  switch (university) {
                                    case "GIST":
                                      return 1;
                                    case "고려대학교":
                                      return 2;
                                    case "UNIST":
                                      return 3;
                                    case "KAIST":
                                      return 4;
                                    case "한양대학교":
                                      return 5;
                                    case "성균관대학교":
                                      return 6;
                                    default:
                                      return 0;
                                  }
                                }

                                //null check
                                bool isNull = false;

                                Map<TextEditingController, String> errorText = {
                                  _nameController: "이름을",
                                  _univController: "대학교를",
                                  _sidController: "학번을",
                                  _yearController: "연도를",
                                  _seasonController: "분기을",
                                  _classController: "분반을",
                                };

                                for (TextEditingController textEditingController
                                    in errorText.keys) {
                                  if (textEditingController.text == "") {
                                    isNull = true;

                                    await showDialog(
                                      context: context,
                                      builder: (_) => CupertinoAlertDialog(
                                        title: Text('Error'),
                                        content: Text(
                                            '${errorText[textEditingController]} 입력해주세요.'),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            isDefaultAction: true,
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop('dialog');
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                    break;
                                  }
                                }

                                //Todo: int.parse의 역할 판단하기.
                                if (!isNull) {
                                  UserInfo userInfo = UserInfo(
                                      name: _nameController.text,
                                      gradOf: int.parse(_sidController.text),
                                      universityId:
                                          getUniversityId(_univController.text),
                                      prtcpntYear:
                                          int.parse('${_yearController.text}${_seasonMap[_seasonController.text]}${_classController.text}'),
                                      interest: []);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InputInfoPage2(
                                                userInfo: userInfo,
                                              )));
                                }
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
