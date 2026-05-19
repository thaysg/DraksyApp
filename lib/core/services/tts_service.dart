import 'dart:async';
import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tts_service.g.dart';

@Riverpod(keepAlive: true)
TtsService ttsService(Ref ref) => TtsService();

class TtsService {
  TtsService() {
    _initFuture = _init();
  }

  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  Future<void>? _initFuture;

  Future<void> _init() async {
    try {
      if (Platform.isAndroid) {
        // Fetch available engines and explicitly set the first one.
        // Without setEngine(), Android may never complete the service binding,
        // producing "speak failed: not bound to TTS engine" indefinitely.
        final engines = await _flutterTts.getEngines;
        if (engines == null || (engines as List).isEmpty) {
          // No TTS engine installed on this device/emulator.
          _isInitialized = false;
          return;
        }
        await _flutterTts.setEngine(engines.first as String);
      }

      await _flutterTts.awaitSpeakCompletion(true);
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1);
      await _flutterTts.setPitch(1);

      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
    }
  }

  static const _kStartTimeout = Duration(milliseconds: 800);
  static const _kMaxAttempts = 5;

  Future<void> speak(String text) async {
    if (text.isEmpty) {
      return;
    }

    await _initFuture;

    if (!_isInitialized) {
      _initFuture = _init();
      await _initFuture;
      if (!_isInitialized) {
        return;
      }
    }

    if (!Platform.isAndroid) {
      await _flutterTts.speak(text);
      return;
    }

    for (var attempt = 1; attempt <= _kMaxAttempts; attempt++) {
      final started = await _speakAndWaitForStart(text);
      if (started) {
        return;
      }
      await Future.delayed(Duration(milliseconds: 400 * attempt));
    }
  }

  Future<bool> _speakAndWaitForStart(String text) async {
    final completer = Completer<bool>();

    _flutterTts
      ..setStartHandler(() {
        if (!completer.isCompleted) {
          completer.complete(true);
        }
      })
      ..setErrorHandler((_) {
        if (!completer.isCompleted) {
          completer.complete(false);
        }
      });

    await _flutterTts.speak(text);

    return completer.future.timeout(
      _kStartTimeout,
      onTimeout: () => false,
    );
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
