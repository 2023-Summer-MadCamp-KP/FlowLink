class UserInfo {
  final String name;
  final int gradOf;
  final int universityId;
  final String uid;
  final int prtcpntYear;

  UserInfo({
    required this.name,
    required this.gradOf,
    required this.universityId,
    required this.uid,
    required this.prtcpntYear,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['name'],
      gradOf: json['gradOf'],
      universityId: json['universityId'],
      uid: json['uid'],
      prtcpntYear: json['prtcpntYear'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gradOf': gradOf,
      'universityId': universityId,
      'uid': uid,
      'prtcpntYear': prtcpntYear,
    };
  }
}
