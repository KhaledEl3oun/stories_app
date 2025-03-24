class SubCategoryResponse {
  final int? results;
  final int? totalSubCategories;
  final int? totalPages;
  final int? currentPage;
  final bool? hasNextPage;
  final bool? hasPrevPage;
  final List<SubCategoryModel> data;

  SubCategoryResponse({
    this.results,
    this.totalSubCategories,
    this.totalPages,
    this.currentPage,
    this.hasNextPage,
    this.hasPrevPage,
    required this.data,
  });

  // تحويل JSON إلى كائن Dart
  factory SubCategoryResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoryResponse(
      results: json['results'] as int?,
      totalSubCategories: json['totalSubCategories'] as int?,
      totalPages: json['totalPages'] as int?,
      currentPage: json['currentPage'] as int?,
      hasNextPage: json['hasNextPage'] as bool?,
      hasPrevPage: json['hasPrevPage'] as bool?,
      data: (json['data'] as List)
          .map((item) => SubCategoryModel.fromJson(item))
          .toList(),
    );
  }

  // تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'results': results,
      'totalSubCategories': totalSubCategories,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'hasNextPage': hasNextPage,
      'hasPrevPage': hasPrevPage,
      'data': data.map((subCategory) => subCategory.toJson()).toList(),
    };
  }
}

class SubCategoryModel {
  final String? id;
  final String? name;
  final String? image;
  final Category? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubCategoryModel({
    this.id,
    this.name,
    this.image,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  // تحويل JSON إلى كائن Dart
  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
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
