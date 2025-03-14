class UserModel {
  final String userName;
  final String email;
  final String phone;
  final String role;
  final String id;
  final String? createdAt;
  final String? updatedAt;
  final List<String>? readStories;
  final List<String>? wishlist;
  final String token;

  UserModel({
    required this.userName,
    required this.email,
    required this.phone,
    required this.role,
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.readStories,
    this.wishlist,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['data']['userName'],
      email: json['data']['email'],
      phone: json['data']['phone'],
      role: json['data']['role'],
      id: json['data']['_id'],
      createdAt: json['data'].containsKey('createdAt') ? json['data']['createdAt'] : null,
      updatedAt: json['data'].containsKey('updatedAt') ? json['data']['updatedAt'] : null,
      readStories: json['data'].containsKey('readStories') ? List<String>.from(json['data']['readStories']) : [],
      wishlist: json['data'].containsKey('wishlist') ? List<String>.from(json['data']['wishlist']) : [],
      token: json['token'],
    );
  }
}
