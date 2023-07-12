class UserInfo {
  final String name;
  final int gradOf;
  final int universityId;
  final int prtcpntYear;
  final List<int> interest;

  UserInfo({
    required this.name,
    required this.gradOf,
    required this.universityId,
    required this.prtcpntYear,
    required this.interest,
  });

  // Named constructor that initializes a UserInfo instance from a Map
  UserInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        gradOf = json['gradOf'],
        universityId = json['universityId'],
        prtcpntYear = json['prtcpntYear'],
        interest = List<int>.from(json['interest']);

  // Method that converts a UserInfo instance into a Map
  Map<String, dynamic> toJson() => {
        'name': name,
        'gradOf': gradOf,
        'universityId': universityId,
        'prtcpntYear': prtcpntYear,
        'interest': interest,
      };
}
