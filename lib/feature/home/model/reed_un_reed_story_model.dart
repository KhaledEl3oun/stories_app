class ReedUnReedStoryModel {
  final String? message;
  final List<String>? readStories;

  ReedUnReedStoryModel({this.message, this.readStories});

  factory ReedUnReedStoryModel.fromJson(Map<String, dynamic> json) {
    return ReedUnReedStoryModel(
      message: json['message'] as String?,
      readStories: (json['readStories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'readStories': readStories,
    };
  }
}
