/// =======================================================
/// File: bookmark_repository.dart
/// Feature: Bookmarks
/// Description:
/// Repository layer for bookmark operations.
///
/// Responsibilities:
/// - Communicate with BookmarkService
/// - Keep UI independent from Firebase
///
/// Author: Pranav Khandelwal
/// Project: News Assistant
/// =======================================================

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../news/data/models/news_model.dart';
import '../services/bookmark_service.dart';

class BookmarkRepository {

  /// Service dependency
  final BookmarkService bookmarkService;

  BookmarkRepository(
      this.bookmarkService,
      );

  /// ===================================================
  /// Save Bookmark
  /// ===================================================

  Future<void> saveBookmark(
      NewsModel article,
      ) async {
    await bookmarkService.saveBookmark(
      article,
    );
  }

  /// ===================================================
  /// Check Bookmark
  /// ===================================================
  Future<bool> isBookmarked(
      NewsModel article,
      ) async {
    return await bookmarkService
        .isBookmarked(article);
  }
  /// ===================================================
  /// Remove Bookmark
  /// ===================================================
  Future<void> removeBookmark(
      NewsModel article,
      ) async {
    await bookmarkService.removeBookmark(
      article.url.hashCode.toString(),
    );
  }

  /// ===================================================
  /// Fetch Bookmark Stream
  /// ===================================================
  Stream<QuerySnapshot>
  getBookmarks() {
    return bookmarkService.getBookmarks();
  }


}