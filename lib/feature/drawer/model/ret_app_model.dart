class ReviewModel {
  final int? rating;
  final String? comment;
  final String? userId;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ReviewModel({
    this.rating,
    this.comment,
    this.userId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  // تحويل JSON إلى كائن Dart
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      userId: json['user'] as String?,
      id: json['_id'] as String?,
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
      'rating': rating,
      'comment': comment,
      'user': userId,
      '_id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}
