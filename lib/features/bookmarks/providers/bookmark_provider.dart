/// =======================================================
/// File: bookmark_provider.dart
/// Feature: Bookmarks
/// Description:
/// Riverpod providers for bookmark management.
///
/// Responsibilities:
/// - Dependency injection
/// - State management
/// - Firestore communication
///
/// Author: Pranav Khandelwal
/// Project: News Assistant
/// =======================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/bookmark_repository.dart';
import '../data/services/bookmark_service.dart';

/// =======================================================
/// Bookmark Service Provider
/// =======================================================
final bookmarkServiceProvider =
Provider<BookmarkService>(
      (ref) => BookmarkService(),
);

/// =======================================================
/// Bookmark Repository Provider
/// =======================================================
final bookmarkRepositoryProvider =
Provider<BookmarkRepository>(
      (ref) => BookmarkRepository(
    ref.read(
      bookmarkServiceProvider,
    ),
  ),
);