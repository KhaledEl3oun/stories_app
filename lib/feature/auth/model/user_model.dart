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

 factory UserModel.fromJson(Map<String, dynamic>? json) {
  if (json == null) {
    throw ArgumentError("❌ JSON is null!");
  }

  final data = json['data'] is Map<String, dynamic> ? json['data'] : json;

  return UserModel(
    userName: data['userName'] as String?,
    email: data['email'] as String?,
    phone: data['phone'] as String?,
    role: data['role'] as String?,
    id: data['_id'] as String?,
    createdAt: data['createdAt'] as String?,
    updatedAt: data['updatedAt'] as String?,
    readStories: (data['readStories'] as List?)?.map((e) => e.toString()).toList() ?? [],
    wishlist: (data['wishlist'] as List?)?.map((e) => e.toString()).toList() ?? [],
    token: json['token'] as String?,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'phone': phone,
      'role': role,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'readStories': readStories ?? [],
      'wishlist': wishlist ?? [],
      'token': token,
    };
  }

}
