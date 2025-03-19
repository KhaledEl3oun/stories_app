class SingleCategoryModel {
  final String? id;
  final String? name;
  final String? image;
  final Category? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  SingleCategoryModel.SingleCategoryModel({
    this.id,
    this.name,
    this.image,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  // تحويل JSON إلى كائن Dart
  factory SingleCategoryModel.fromJson(Map<String, dynamic> json) {
    return SingleCategoryModel.SingleCategoryModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'] as int?,
    );
  }

  // تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'category': category?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}

class Category {
  final String? name;

  Category({this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
