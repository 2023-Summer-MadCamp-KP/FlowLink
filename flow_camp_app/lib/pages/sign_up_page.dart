import 'package:dio/dio.dart';
import 'package:flow_camp_app/components/loading_indicator_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/urls.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // int _counter = 0;
  bool _isLoading = false;
  late TextEditingController _idController, _pwController, _pwConfirmController;
  bool _isObscure = true;
  late FocusNode _idFocusNode, _pwFocusNode, _pwConfirmFocusNode;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _pwController = TextEditingController();
    _pwConfirmController = TextEditingController();
    _idFocusNode = FocusNode();
    _pwFocusNode = FocusNode();
    _pwConfirmFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    _pwConfirmController.dispose();
    _idFocusNode.dispose();
    _pwFocusNode.dispose();
    _pwConfirmFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _signUp() async {
      if (_pwController.text != _pwConfirmController.text) {
        await showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: Text('Error'),
            content: Text('비밀번호가 일치하지 않습니다.'),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
              ),
            ],
          ),
        );
      } 
      else if(_idController.text == ""){
        await showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: Text('Error'),
            content: Text('아이디를 입력해주세요.'),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
              ),
            ],
          ),
        );
      }
      else if(_pwController.text == ""){
        await showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: Text('Error'),
            content: Text('비밀번호를 입력해주세요.'),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
              ),
            ],
          ),
        );
      }
      else {
        setState(() {
          _isLoading = true;
        });
        Dio dio = Dio();
        try {
          var response = await dio.post('${DIO_BASE_URL}/api/signup', data: {
            'uid': _idController.text,
            'password': _pwController.text,
            'platform': 'normal',
          });

          await showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: Text('Success'),
              content: Text('회원가입이 완료되었습니다. 로그인해주세요.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                ),
              ],
            ),
          );
          Navigator.pop(context);
        } catch (e) {
          print(e);
          await showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: Text('Error'),
              content: Text('회원가입이 거절되었습니다.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                ),
              ],
            ),
          );
        }

        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
      return;
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(),
          ),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: _isLoading
                  ? LoadingIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: Image.asset(
                                    "assets/images/flowlinkLogo.png"),
                              ),
                              const SizedBox(
                                width: double.infinity,
                                height: 30,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: CupertinoTextField(
                                  controller: _idController,
                                  focusNode: _idFocusNode,
                                  textInputAction: TextInputAction.next,
                                  padding: const EdgeInsets.only(left: 10),
                                  textAlignVertical: TextAlignVertical.center,
                                  placeholder: "아이디",
                                  placeholderStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                      color: Colors.grey),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 248, 248, 248),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color.fromARGB(
                                            255, 220, 220, 220),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: double.infinity,
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: CupertinoTextField(
                                  controller: _pwController,
                                  obscureText: _isObscure,
                                  focusNode: _pwFocusNode,
                                  textInputAction: TextInputAction.go,
                                  padding: const EdgeInsets.only(left: 10),
                                  textAlignVertical: TextAlignVertical.center,
                                  placeholder: "비밀번호",
                                  placeholderStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                      color: Colors.grey),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 248, 248, 248),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color.fromARGB(
                                            255, 220, 220, 220),
                                      )),
                                  suffix: SizedBox(
                                    width: 40,
                                    height: double.infinity,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                      icon: Icon(
                                          _isObscure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: double.infinity,
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: CupertinoTextField(
                                  controller: _pwConfirmController,
                                  obscureText: true,
                                  focusNode: _pwConfirmFocusNode,
                                  textInputAction: TextInputAction.go,
                                  padding: const EdgeInsets.only(left: 10),
                                  textAlignVertical: TextAlignVertical.center,
                                  placeholder: "비밀번호 확인",
                                  placeholderStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                      color: Colors.grey),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 248, 248, 248),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color.fromARGB(
                                            255, 220, 220, 220),
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
                                    "회원가입",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    _signUp();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
