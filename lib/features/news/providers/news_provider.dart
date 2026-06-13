/// =======================================================
/// File: news_provider.dart
/// Feature: News
/// Description:
/// Riverpod providers for News feature.
///
/// Responsibilities:
/// - Dependency Injection
/// - State Management
/// - API Call Management
/// =======================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/news_model.dart';
import '../data/repositories/news_repository.dart';
import '../data/services/news_api_service.dart';

/// Provides NewsApiService instance
final newsApiProvider =
Provider<NewsApiService>(
      (ref) => NewsApiService(),
);

/// Provides NewsRepository instance
final newsRepositoryProvider =
Provider<NewsRepository>(
      (ref) => NewsRepository(
    ref.read(newsApiProvider),
  ),
);

/// Fetches latest news articles
final topNewsProvider =
FutureProvider<List<NewsModel>>(
      (ref) async {

    return ref
        .read(newsRepositoryProvider)
        .getTopNews();
  },
);