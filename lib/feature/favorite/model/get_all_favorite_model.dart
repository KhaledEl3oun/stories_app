class GetAllFavoriteModel {
  String? id;
  String? title;
  String? imageCover;
  List<String>? images;
  String? category;
  String? subCategory;
  bool? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetAllFavoriteModel({
    this.id,
    this.title,
    this.imageCover,
    this.images,
    this.category,
    this.subCategory,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  // **تحويل JSON إلى كائن Dart**
  factory GetAllFavoriteModel.fromJson(Map<String, dynamic> json) {
    return GetAllFavoriteModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      imageCover: json['imageCover'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category: json['category'] as String?,
      subCategory: json['subCategory'] as String?,
      isRead: json['isRead'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  // **تحويل كائن Dart إلى JSON**
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'imageCover': imageCover,
      'images': images,
      'category': category,
      'subCategory': subCategory,
      'isRead': isRead,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
