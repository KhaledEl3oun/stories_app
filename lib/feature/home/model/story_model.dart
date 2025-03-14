class StoryModel {
  final String id;
  final String title;
  final String imageCover;
  final List<String> images;
  final String categoryId;
  final String categoryName;
  final String subCategoryId;
  final String subCategoryName;
  final bool isRead;
  final String createdAt;
  final String updatedAt;

  StoryModel({
    required this.id,
    required this.title,
    required this.imageCover,
    required this.images,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  // 🟢 تحويل JSON إلى `StoryModel`
  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'بدون عنوان',
      imageCover: json['imageCover'] ?? 'https://via.placeholder.com/150',
      images: (json['images'] as List?)?.map((img) => img.toString()).toList() ?? [],
      categoryId: json['category']?['_id'] ?? '',
      categoryName: json['category']?['name'] ?? 'غير معروف',
      subCategoryId: json['subCategory']?['_id'] ?? '',
      subCategoryName: json['subCategory']?['name'] ?? 'غير معروف',
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
  