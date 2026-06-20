/// =======================================================
/// File: bookmark_service.dart
/// Feature: Bookmarks
/// Description:
/// Handles all Firestore operations related to bookmarks.
///
/// Responsibilities:
/// - Save bookmark
/// - Remove bookmark
/// - Fetch bookmarks
///
/// Author: Pranav Khandelwal
/// Project: News Assistant
/// =======================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../news/data/models/news_model.dart';

class BookmarkService {

  /// Firestore instance
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// Firebase Auth instance
  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  /// ===================================================
  /// Check if article already bookmarked
  /// ===================================================
  Future<bool> isBookmarked(
      NewsModel article,
      ) async {

    final user = _auth.currentUser;

    if (user == null) return false;

    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookmarks')
        .doc(article.url.hashCode.toString())
        .get();

    return doc.exists;
  }

  /// ===================================================
  /// Delete Bookmark
  /// ===================================================
  Future<void> removeBookmark(
      String articleId,
      ) async {

    final user = _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookmarks')
        .doc(articleId)
        .delete();
  }
  /// ===================================================
  /// Save Bookmark
  /// ===================================================
  Future<void> saveBookmark(
      NewsModel article,
      ) async {

    final user = _auth.currentUser;

    if (user == null) {
      throw Exception(
        "User not logged in",
      );
    }

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookmarks')
        .doc(article.url.hashCode.toString())
        .set({
      'title': article.title,
      'description': article.description,
      'content': article.content,
      'image': article.image,
      'url': article.url,
      'source': article.source,
      'publishedAt': article.publishedAt,
      'savedAt': Timestamp.now(),
    });

    print("BOOKMARK SAVED SUCCESSFULLY");
  }
  /// ===================================================
  /// Fetch Bookmarks Stream
  /// ===================================================
  Stream<QuerySnapshot>
  getBookmarks() {

    final user = _auth.currentUser;

    if (user == null) {
      throw Exception(
        "User not logged in",
      );
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookmarks')
        .orderBy(
      'savedAt',
      descending: true,
    )
        .snapshots();
  }
}