part of 'models.dart';

class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;

  static String? token;

  UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        profileImage: json['profile_image'],
      );

  UserModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
  }) =>
      UserModel(
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}
