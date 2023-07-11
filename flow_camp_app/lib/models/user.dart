import 'package:flow_camp_app/models/university.dart';

class User {
  final int id;
  final String name;
  final String? token;
  final int gradOf;
  final String uid;
  final String password;
  final String platform;
  final int prtcpntYear;
  final bool emailConfirmed;
  final bool infoConfirmed;
  final University university;

  User({
    required this.id,
    required this.name,
    this.token,
    required this.gradOf,
    required this.uid,
    required this.password,
    required this.platform,
    required this.prtcpntYear,
    required this.emailConfirmed,
    required this.infoConfirmed,
    required this.university,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      token: json['token'],
      gradOf: json['gradOf'],
      uid: json['uid'],
      password: json['password'],
      platform: json['platform'],
      prtcpntYear: json['prtcpntYear'],
      emailConfirmed: json['emailConfirmed'],
      infoConfirmed: json['infoConfirmed'],
       university: University.fromJson(json['university']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'token': token,
      'gradOf': gradOf,
      'uid': uid,
      'password': password,
      'platform': platform,
      'prtcpntYear': prtcpntYear,
      'emailConfirmed': emailConfirmed,
      'infoConfirmed': infoConfirmed,
      'university': university.toJson(),
    };
  }
}
