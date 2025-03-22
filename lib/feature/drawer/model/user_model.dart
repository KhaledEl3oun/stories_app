import 'dart:convert';

class UserUpdateModel {
  final String? id;
  final String? userName;
  final String? email;
  final String? role;
  final List<String>? readStories;
  final List<String>? wishlist;
  final String? profileImg;
  final String? createdAt;
  final String? updatedAt;
  final String? passwordChangedAt;
  final String? token;

  UserUpdateModel({
    this.id,
    this.userName,
    this.email,
    this.role,
    this.readStories,
    this.wishlist,
    this.profileImg,
    this.createdAt,
    this.updatedAt,
    this.passwordChangedAt,
    this.token,
  });

  /// 🟢 تحويل JSON إلى كائن `UserUpdateModel`
  factory UserUpdateModel.fromJson(Map<String, dynamic> json) {
    return UserUpdateModel(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
      readStories: json['readStories'] != null ? List<String>.from(json['readStories']) : null,
      wishlist: json['wishlist'] != null ? List<String>.from(json['wishlist']) : null,
      profileImg: json['profileImg'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      passwordChangedAt: json['passwordChangedAt'],
      token: json['token'],
    );
  }

  /// 🟢 تحويل `UserUpdateModel` إلى JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "userName": userName,
      "email": email,
      "role": role,
      "readStories": readStories,
      "wishlist": wishlist,
      "profileImg": profileImg,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "passwordChangedAt": passwordChangedAt,
      "token": token,
    };
  }

  /// 🟢 تحويل نص JSON إلى كائن `UserUpdateModel`
  static UserUpdateModel fromJsonString(String jsonString) {
    return UserUpdateModel.fromJson(jsonDecode(jsonString));
  }

  /// 🟢 تحويل كائن `UserUpdateModel` إلى نص JSON
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
