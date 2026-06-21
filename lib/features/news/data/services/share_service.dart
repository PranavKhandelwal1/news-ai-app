/// =======================================================
/// File: share_service.dart
/// Feature: News
/// Description:
/// Handles article sharing.
///
/// Responsibilities:
/// - Share article link
/// - Share article content
///
/// Author: Pranav Khandelwal
/// Project: News Assistant
/// =======================================================

import 'package:share_plus/share_plus.dart';

class ShareService {

  /// ===================================================
  /// Share Article
  /// ===================================================
  Future<void> shareArticle({
    required String title,
    required String url,
  }) async {

    await SharePlus.instance.share(
      ShareParams(
        text:
        "$title\n\nRead more here:\n$url",
      ),
    );
  }
}