class Interest {
  final String name;
  final String category;
  final bool confirmed;

  Interest({
    required this.name,
    required this.category,
    required this.confirmed,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'confirmed': confirmed,
    };
  }

  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(
      name: json['name'],
      category: json['category'],
      confirmed: json['confirmed'],
    );
  }
}
