/// =======================================================
/// File: gemini_service.dart
/// Feature: Assistant
/// Description:
/// Handles AI summarization using Gemini API.
///
/// Responsibilities:
/// - Send article text to Gemini
/// - Generate summary
///
/// Author: Pranav Khandelwal
/// Project: News Assistant
/// =======================================================

import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../core/constants/app_constants.dart';

class GeminiService {

  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: AppConstants.geminiApiKey,
  );

  /// ===================================================
  /// Generate News Summary
  /// ===================================================
  Future<String> generateSummary(
      String articleText,
      ) async {

    final prompt = """
Summarize this news article in 3 short bullet points:

$articleText
""";

    final response = await model.generateContent(
      [
        Content.text(prompt),
      ],
    );

    return response.text ??
        "No summary available";
  }
}