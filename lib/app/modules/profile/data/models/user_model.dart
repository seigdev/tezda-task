import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String fullName;
  String email;
  String phone;

  static String get userId => FirebaseAuth.instance.currentUser!.uid;

  static String? image = FirebaseAuth.instance.currentUser!.photoURL;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullName: json["full_name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "phone": phone,
      };
}
