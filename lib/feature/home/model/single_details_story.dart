class SingleStoryModel {
  final String? id;
  final String? title;
  final String? imageCover;
  final List<String>? images;
  final String? category;
  final String? subCategory;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  SingleStoryModel({
    this.id,
    this.title,
    this.imageCover,
    this.images,
    this.category,
    this.subCategory,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  // تحويل JSON إلى كائن Dart
  factory SingleStoryModel.fromJson(Map<String, dynamic> json) {
    return SingleStoryModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      imageCover: json['imageCover'] as String?,
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category: json['category'] as String?,
      subCategory: json['subCategory'] as String?,
      isRead: json['isRead'] as bool?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'] as int?,
    );
  }

  // تحويل كائن Dart إلى JSON
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
      '__v': v,
    };
  }
}
