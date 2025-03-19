class AddFavoriteModel {
  String? status;
  String? message;
  List<String>? data;

  AddFavoriteModel({this.status, this.message, this.data});

  // **تحويل JSON إلى كائن Dart**
  factory AddFavoriteModel.fromJson(Map<String, dynamic> json) {
    return AddFavoriteModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  // **تحويل كائن Dart إلى JSON**
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
