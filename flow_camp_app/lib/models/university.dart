class University {
  final String name;
  final String major;
  final bool confirmed;

  University({
    required this.name,
    required this.major,
    required this.confirmed,
  });

  // Convert a University object into a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'major': major,
      'confirmed': confirmed,
    };
  }

  // Create a University object from a Map
  static University fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      major: json['major'],
      confirmed: json['confirmed'],
    );
  }
}
