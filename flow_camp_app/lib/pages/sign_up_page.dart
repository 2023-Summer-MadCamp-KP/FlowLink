import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    Future<void> _signUp () async{
      if (_pwController.text != _pwConfirmController.text) {
          showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: Text('Error'),
              content: Text('The passwords do not match. Please try again.'),
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
      return;
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(

          ),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
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
                              child: Image.asset("assets/images/flowlinkLogo.png"),
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
                                placeholder: "Confirm Password",
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
                                    "Sign Up",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: _signUp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
