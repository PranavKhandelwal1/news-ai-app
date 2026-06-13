/// =======================================================
/// File: news_model.dart
/// Feature: News
/// Description:
/// Model class representing a news article.
///
/// This model converts JSON received from the GNews API
/// into a strongly typed Dart object.
/// =======================================================

class NewsModel {

  /// News headline/title
  final String title;

  /// Short summary of the article
  final String description;

  /// Full article content (if provided)
  final String content;

  /// Article image URL
  final String image;

  /// Original article URL
  final String url;

  /// News source name
  final String source;

  /// Article publication date
  final String publishedAt;

  NewsModel({
    required this.title,
    required this.description,
    required this.content,
    required this.image,
    required this.url,
    required this.source,
    required this.publishedAt,
  });

  /// Converts JSON response into NewsModel object
  factory NewsModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      image: json['image'] ?? '',
      url: json['url'] ?? '',
      source: json['source']?['name'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}