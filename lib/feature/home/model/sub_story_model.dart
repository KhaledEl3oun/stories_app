class SubStoryResponse {
  final int? results;
  final int? totalStories;
  final int? totalPages;
  final int? currentPage;
  final bool? hasNextPage;
  final bool? hasPrevPage;
  final List<SubStoryModel> data;

  SubStoryResponse({
    this.results,
    this.totalStories,
    this.totalPages,
    this.currentPage,
    this.hasNextPage,
    this.hasPrevPage,
    required this.data,
  });

  // تحويل JSON إلى كائن Dart
  factory SubStoryResponse.fromJson(Map<String, dynamic> json) {
    return SubStoryResponse(
      results: json['results'] as int?,
      totalStories: json['totalStories'] as int?,
      totalPages: json['totalPages'] as int?,
      currentPage: json['currentPage'] as int?,
      hasNextPage: json['hasNextPage'] as bool?,
      hasPrevPage: json['hasPrevPage'] as bool?,
      data: (json['data'] as List<dynamic>)
          .map((story) => SubStoryModel.fromJson(story))
          .toList(),
    );
  }

  // تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'results': results,
      'totalStories': totalStories,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'hasNextPage': hasNextPage,
      'hasPrevPage': hasPrevPage,
      'data': data.map((story) => story.toJson()).toList(),
    };
  }
}

class SubStoryModel {
  final String? id;
  final String? title;
  final String? imageCover;
  final List<String>? images;
  final Category? category;
  final Category? subCategory;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  SubStoryModel({
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
  factory SubStoryModel.fromJson(Map<String, dynamic> json) {
    return SubStoryModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      imageCover: json['imageCover'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      subCategory: json['subCategory'] != null
          ? Category.fromJson(json['subCategory'])
          : null,
      isRead: json['isRead'] as bool?,
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
      'title': title,
      'imageCover': imageCover,
      'images': images,
      'category': category?.toJson(),
      'subCategory': subCategory?.toJson(),
      'isRead': isRead,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}

class Category {
  final String? id;
  final String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
