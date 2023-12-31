import 'package:flow_camp_app/components/loading_indicator_page.dart';
import 'package:flow_camp_app/constants/urls.dart';
import 'package:flow_camp_app/pages/input_info1_page.dart';
import 'package:flow_camp_app/pages/sign_up_page.dart';
import 'package:flow_camp_app/pages/tab_navigation_page.dart';
import 'package:flow_camp_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.title});
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
  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _pwController = TextEditingController();
    _idFocusNode = FocusNode();
    _pwFocusNode = FocusNode();

    IO.Socket socket = IO.io( SOCKET_BASE_URL, <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('connected');
    });

    socket.on('message', (data) => print(data));
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
      userProvider.postSignIn(
          context, _idController.text, _pwController.text, "normal");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    Future<void> _afterSuccess() async {
      User user;
      setState(() {
        _isLoading = true;
      });
      try {
        user = await UserApi.instance.me();
        print('사용자 정보 요청 성공'
            '\n회원번호: ${user.id}'
            '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
            '\n이메일: ${user.kakaoAccount?.email}');
        await userProvider.postSignIn(context, "kakao" + user.id.toString(),
            "kakao" + user.id.toString(), "kakao");
      } catch (error) {
        print('사용자 정보 요청 실패 $error');
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
          await _afterSuccess();
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
            await _afterSuccess();
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
          await _afterSuccess();
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
                              height: 50,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: CupertinoButton.filled(
                                  padding: const EdgeInsets.all(0),
                                  child: const Text(
                                    "로그인",
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
                                      "카카오톡으로 로그인",
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
                                        "네이버로 로그인",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    print("dd");
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           InputInfoPage1()),
                                    // );
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
                                        "구글로 로그인",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    print("dd");
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           TabNavigationPage()),
                                    // );
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
                              child: Text(
                                "회원가입",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
