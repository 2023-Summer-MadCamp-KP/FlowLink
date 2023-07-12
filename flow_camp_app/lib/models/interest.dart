class Interest {
  final int id;
  final String name;
  final String category;
  final bool confirmed;

  Interest({
    required this.id,
    required this.name,
    required this.category,
    required this.confirmed,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'confirmed': confirmed,
    };
  }

  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(
      id:json['id'],
      name: json['name'],
      category: json['category'],
      confirmed: json['confirmed'],
    );
  }
}
