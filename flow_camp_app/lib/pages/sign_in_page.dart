import 'package:flow_camp_app/components/loading_indicator_page.dart';
import 'package:flow_camp_app/constants/urls.dart';
import 'package:flow_camp_app/pages/input_info_page.dart';
import 'package:flow_camp_app/pages/sign_up_page.dart';
import 'package:flow_camp_app/pages/tab_navigation_page.dart';
import 'package:flow_camp_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // int _counter = 0;
  bool _isLoading = false;
  late TextEditingController _idController, _pwController;
  bool _isObscure = true;
  late FocusNode _idFocusNode, _pwFocusNode;

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
    _idController = TextEditingController();
    _pwController = TextEditingController();
    _idFocusNode = FocusNode();
    _pwFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    _idFocusNode.dispose();
    _pwFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    Future<void> _signInWithNormal() async {
      setState(() {
        _isLoading = true;
      });
      Dio dio = Dio();
      try {
        var response = await dio.post('${DIO_BASE_URL}/signin', data: {
          'uid': _idController.text,
          'password': _pwController.text,
          'platform': 'normal',
        });
        userProvider.setSignIn(true);
      } catch (e) {
        print(e);
        await showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: Text('Error'),
            content: Text('로그인이 거절되었습니다.'),
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
      setState(() {
        _isLoading = false;
      });
      return;
    }

    Future<void> _signInWithKakao() async {
      if (await isKakaoTalkInstalled()) {
        try {
          setState(() {
            _isLoading = true;
          });
          await UserApi.instance.loginWithKakaoTalk();
          userProvider.setSignIn(true);
          print('카카오톡으로 로그인 성공');
        } catch (error) {
          print('카카오톡으로 로그인 실패 $error');

          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (error is PlatformException && error.code == 'CANCELED') {
            return;
          }
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
          try {
            setState(() {
              _isLoading = true;
            });
            await UserApi.instance.loginWithKakaoAccount();
            userProvider.setSignIn(true);
            print('카카오계정으로 로그인 성공');
          } catch (error) {
            print('카카오계정으로 로그인 실패 $error');
          }
        }
      } else {
        try {
          setState(() {
            _isLoading = true;
          });
          await UserApi.instance.loginWithKakaoAccount();

          try {
            User user = await UserApi.instance.me();
            print('사용자 정보 요청 성공'
                '\n회원번호: ${user.id}'
                '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
                '\n이메일: ${user.kakaoAccount?.email}');
          } catch (error) {
            print('사용자 정보 요청 실패 $error');
          }
          userProvider.setSignIn(true);
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
      setState(() {
        _isLoading = false;
      });
      return;
    }

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
      child: Scaffold(
        // appBar: CupertinoNavigationBar(
        //   // TRY THIS: Try changing the color here to a specific color (to
        //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        //   // change color while the other colors stay the same.
        //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //   // Here we take the value from the MyHomePage object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   middle: Text(widget.title),
        // ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: _isLoading
            ? LoadingIndicator()
            : SafeArea(
                child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Center(
                        // Center is a layout widget. It takes a single child and positions it
                        // in the middle of the parent.
                        child: Column(
                          // Column is also a layout widget. It takes a list of children and
                          // arranges them vertically. By default, it sizes itself to fit its
                          // children horizontally, and tries to be as tall as its parent.
                          //
                          // Column has various properties to control how it sizes itself and
                          // how it positions its children. Here we use mainAxisAlignment to
                          // center the children vertically; the main axis here is the vertical
                          // axis because Columns are vertical (the cross axis would be
                          // horizontal).
                          //
                          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                          // action in the IDE, or press "p" in the console), to see the
                          // wireframe for each widget.
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 200,
                              height: 50,
                              child:
                                  Image.asset("assets/images/flowlinkLogo.png"),
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
                                placeholder: "Username",
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
                                placeholder: "Password",
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
                              height: 50,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: CupertinoButton.filled(
                                  padding: const EdgeInsets.all(0),
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: _signInWithNormal),
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Stack(
                                children: [
                                  const Align(
                                      alignment: Alignment.center,
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      )),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 60,
                                        height: 20,
                                        color: Colors.white,
                                        child: const Center(
                                          child: Text(
                                            "OR",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    splashFactory: NoSplash.splashFactory,
                                    padding: const EdgeInsets.all(0),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: Image.asset(
                                          "assets/images/kakao_icon.png"),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                      height: double.infinity,
                                    ),
                                    const Text(
                                      "Sign In with KaKao",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                onPressed: _signInWithKakao,
                              ),
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      splashFactory: NoSplash.splashFactory,
                                      padding: const EdgeInsets.all(0),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: Image.asset(
                                            "assets/images/naver_icon.png"),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                        height: double.infinity,
                                      ),
                                      const Text(
                                        "Sign In with Naver",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    print("dd");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InputInfoPage()),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      splashFactory: NoSplash.splashFactory,
                                      padding: const EdgeInsets.all(0),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: Image.asset(
                                            "assets/images/googleIcon.png"),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                        height: double.infinity,
                                      ),
                                      const Text(
                                        "Sign In with Google",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    print("dd");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TabNavigationPage()),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()),
                                );
                              },
                              child: Text("회원 가입 하기"),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
      ),
    );
  }
}
