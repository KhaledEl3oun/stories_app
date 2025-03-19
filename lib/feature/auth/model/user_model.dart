class UserModel {
  final String? userName;
  final String? email;
  final String? phone;
  final String? role;
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final List<String>? readStories;
  final List<String>? wishlist;
  final String? token;

  UserModel({
    this.userName,
    this.email,
    this.phone,
    this.role,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.readStories,
    this.wishlist,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['data']?['userName'],
      email: json['data']?['email'],
      phone: json['data']?['phone'],
      role: json['data']?['role'],
      id: json['data']?['_id'],
      createdAt: json['data']?.containsKey('createdAt') == true
          ? json['data']['createdAt']
          : null,
      updatedAt: json['data']?.containsKey('updatedAt') == true
          ? json['data']['updatedAt']
          : null,
      readStories: json['data']?.containsKey('readStories') == true
          ? List<String>.from(json['data']['readStories'])
          : [],
      wishlist: json['data']?.containsKey('wishlist') == true
          ? List<String>.from(json['data']['wishlist'])
          : [],
      token: json['token'],
    );
  }
}
