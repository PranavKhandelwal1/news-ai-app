/// =======================================================
/// File: tts_service.dart
/// Feature: Assistant
/// Description:
/// Handles Text-to-Speech functionality.
///
/// Responsibilities:
/// - Speak text
/// - Stop speech
/// - Pause speech
///
/// Author: Pranav Khandelwal
/// Project: News Assistant
/// =======================================================

import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts =
  FlutterTts();

  /// ===================================================
  /// Speak Text
  /// ===================================================
  Future<void> speak(
      String text,
      ) async {

    await _flutterTts.setLanguage(
      "en-US",
    );

    await _flutterTts.setSpeechRate(
      0.45,
    );

    await _flutterTts.setPitch(
      1.0,
    );

    await _flutterTts.speak(text);
  }

  /// ===================================================
  /// Stop Speaking
  /// ===================================================
  Future<void> stop() async {
    await _flutterTts.stop();
  }
}