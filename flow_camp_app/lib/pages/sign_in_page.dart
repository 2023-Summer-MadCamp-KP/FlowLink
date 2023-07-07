import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  late TextEditingController _idController, _pwController;

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
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
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
    return Scaffold(
      // appBar: CupertinoNavigationBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   middle: Text(widget.title),
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  const Text(
                    "FlowLink",
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height:40,
                    child: CupertinoTextField(
                      controller: _idController,
                      textAlignVertical: TextAlignVertical.center,
                      placeholder: "Username",
                      placeholderStyle: const TextStyle(fontSize: 12, height: 1.5, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height:40,
                    child:CupertinoTextField(
                      controller: _pwController,
                      textAlignVertical: TextAlignVertical.center,
                      placeholder: "Password",
                      placeholderStyle: const TextStyle(fontSize: 12, height: 1.5, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height:40,
                    child: CupertinoButton.filled(
                        padding: const EdgeInsets.all(0),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 13),
                        ),
                        onPressed: (){}
                    ),
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
                              color: Colors.grey,
                            )
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 40,
                              height: 20,
                              color: Colors.white,
                              child: const Center(
                                child: Text(
                                  "OR",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height:40,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        padding: const EdgeInsets.all(0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: Image.asset("images/googleIcon.png"),
                          ),
                          const SizedBox(
                            width: 5,
                            height: double.infinity,
                          ),
                          const Text(
                            "Sign In with Google",
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                        ],
                      ),
                      onPressed: (){}
                    ),
                  ),
                  // Text(
                  //   '$_counter',
                  //   style: Theme.of(context).textTheme.headlineMedium,
                  // ),
                ],
              ),
            ),
          )
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}