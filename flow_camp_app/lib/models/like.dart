import 'package:flow_camp_app/models/user.dart';

class Like {
  final int likeFrom;
  final int likeTo;
  final User likeFromUser;
  final User likeToUser;

  Like({
    required this.likeFrom,
    required this.likeTo,
    required this.likeFromUser,
    required this.likeToUser,
  });

  Map<String, dynamic> toJson() {
    return {
      'likeFrom': likeFrom,
      'likeTo': likeTo,
      'likeFromUser': likeFromUser.toJson(),
      'likeToUser': likeToUser.toJson(),
    };
  }

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      likeFrom: json['likeFrom'],
      likeTo: json['likeTo'],
      likeFromUser: User.fromJson(json['likeFromUser']),
      likeToUser: User.fromJson(json['likeToUser']),
    );
  }
}

