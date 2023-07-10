import 'package:flow_camp_app/pages/sign_in_page.dart';
import 'package:flow_camp_app/pages/tab_navigation_page.dart';
import 'package:flow_camp_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '6725dbe3bff09a71cac3b67b4f6fb365',
    javaScriptAppKey: '1606d225c4d489ebb2d9decf625bda42',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool ise = false;

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();
    bool isSignedIn = true;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: userProvider.isSignIn
            ? TabNavigationPage()
            : SignInPage(title: 'Flutter Demo Home Page'));
  }
}
