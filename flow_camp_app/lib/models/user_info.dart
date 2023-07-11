class UserInfo {
  final String name;
  final int gradOf;
  final int universityId;
  final int prtcpntYear;
  final List<Map<String, String>> interest;

  UserInfo({
    required this.name,
    required this.gradOf,
    required this.universityId,
    required this.prtcpntYear,
    required this.interest,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['name'],
      gradOf: json['gradOf'],
      universityId: json['universityId'],
      prtcpntYear: json['prtcpntYear'],
      interest: json['interest'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gradOf': gradOf,
      'universityId': universityId,
      'prtcpntYear': prtcpntYear,
      'interest': interest,
    };
  }
}
