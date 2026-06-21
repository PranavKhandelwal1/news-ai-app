/// =======================================================
/// File: share_provider.dart
/// Feature: News
/// Description:
/// Riverpod provider for Share Service.
/// =======================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/share_service.dart';

final shareProvider =
Provider<ShareService>(
      (ref) => ShareService(),
);