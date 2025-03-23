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
  final data = json.containsKey('data') ? json['data'] : json; // تأكد من وجود 'data' أولًا
  return UserModel(
    userName: data['userName'],
    email: data['email'],
    phone: data['phone'],
    role: data['role'],
    id: data['_id'],
    createdAt: data['createdAt'],
    updatedAt: data['updatedAt'],
    readStories: data.containsKey('readStories')
        ? List<String>.from(data['readStories'])
        : [],
    wishlist: data.containsKey('wishlist')
        ? List<String>.from(data['wishlist'])
        : [],
    token: json['token'],
  );
}

}
