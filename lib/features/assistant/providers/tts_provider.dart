/// =======================================================
/// File: tts_provider.dart
/// Feature: Assistant
/// Description:
/// Riverpod provider for TTS service.
/// =======================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/tts_service.dart';

final ttsProvider =
Provider<TtsService>(
      (ref) => TtsService(),
);