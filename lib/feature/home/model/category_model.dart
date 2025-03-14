class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id']?.toString() ?? 'غير معروف', 
      name: json['name'] ?? 'بدون اسم',
      image: json['image'] ?? 'assets/images/on_boarding_page1.png',
    );
  }
}
