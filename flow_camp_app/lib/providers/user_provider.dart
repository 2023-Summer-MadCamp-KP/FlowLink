import 'package:dio/dio.dart';
import 'package:flow_camp_app/constants/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//'현재 숫자: ${context.watch<Counter>().count} 처럼 사용
class UserProvider extends ChangeNotifier {
  bool _isSignIn = false;
  bool get isSignIn => _isSignIn;
  void setSignIn(bool isSignIn) {
    _isSignIn = isSignIn;
    notifyListeners();
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

// 토큰 불러오기
  Future<String?> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options?> loadTokenOption() async {
    String? token = await loadToken();
    return Options(
      headers: {
        'authorization': token,
      },
    );
  }

  Future<void> apiSignIn(context, idtext, pwtext) async {
    try {
      Dio dio = Dio();
      var response = await dio.post('${DIO_BASE_URL}/api/signin', data: {
        'uid': idtext,
        'password': pwtext,
        'platform': 'normal',
      });
      final token = response.headers['Authorization']?.first;
      saveToken(token!);
      setSignIn(true);
    } catch (e) {
      print(e);
      await showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text('Error'),
          content: Text('로그인이 실패했습니다.'),
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
  }

  Future<void> apiMe() async {
    try {
//---example
      Dio dio = Dio();
      var options = await loadTokenOption();

      final response = await dio.get(
        '${DIO_BASE_URL}/api/me',
        options: options,
      );
//--
      print('Token is valid');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        print('Token is invalid');
        setSignIn(false);
        // 401 에러 처리
      }
    } catch (e) {
      print('Token is invalid');
    }
    notifyListeners();
    return;
  }

  Future<void> apiSignOut() async {
    try {
      Dio dio = Dio();
      var options = await loadTokenOption();
      await dio.post(
        '${DIO_BASE_URL}/api/signout',
        options: options,
      );
      setSignIn(false);
    }
    on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        print('Token is invalid');
        setSignIn(false);
        // 401 에러 처리
      }
    }  catch (e) {
      print(e);
    }
    return;
  }
}
