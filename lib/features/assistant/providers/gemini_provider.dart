/// =======================================================
/// File: gemini_provider.dart
/// Feature: Assistant
/// Description:
/// Riverpod provider for Gemini Service.
/// =======================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/gemini_service.dart';

final geminiProvider =
Provider<GeminiService>(
      (ref) => GeminiService(),
);