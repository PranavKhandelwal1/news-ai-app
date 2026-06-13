/// =======================================================
/// File: news_repository.dart
/// Feature: News
/// Description:
/// Repository layer.
///
/// Acts as a bridge between:
/// UI Layer <-> API Service
///
/// Keeps business logic separate from UI.
/// =======================================================

import '../models/news_model.dart';
import '../services/news_api_service.dart';

class NewsRepository {

  final NewsApiService apiService;

  NewsRepository(this.apiService);

  /// Fetch top news and convert JSON into NewsModel
  Future<List<NewsModel>> getTopNews() async {

    final articles =
    await apiService.getTopHeadlines();

    return articles
        .map<NewsModel>(
          (json) => NewsModel.fromJson(json),
    )
        .toList();
  }
}