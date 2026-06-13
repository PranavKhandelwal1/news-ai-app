/// =======================================================
/// File: news_api_service.dart
/// Feature: News
/// Description:
/// Handles communication with GNews API.
///
/// Responsible for:
/// - Fetching latest headlines
/// - Fetching category news
/// - Searching news articles
/// =======================================================

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/constants/app_constants.dart';

class NewsApiService {

  /// Fetches top headlines from GNews API
  Future<List<dynamic>> getTopHeadlines() async {

    final url =
        '${AppConstants.baseUrl}/top-headlines?category=general&lang=en&country=us&max=20&apikey=${AppConstants.gnewsApiKey}';

    final response = await http.get(
      Uri.parse(url),
    );

    /// Success Response
    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return data['articles'];
    }

    /// Failure Response
    throw Exception(
      'Failed to load news',
    );
  }
}