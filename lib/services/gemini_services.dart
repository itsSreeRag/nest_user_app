import 'dart:developer';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiServices {
  final Gemini _gemini = Gemini.instance;

  Stream<String> getGeminiResponse({required String question}) async* {
    final parts = <Part>[Part.text(question)];
    String fullResponse = '';

    await for (final value in _gemini.promptStream(parts: parts)) {
      if (value?.output != null) {
        final chunk = value!.output!;
        fullResponse += chunk;
        yield fullResponse; 
        log('[Gemini] $chunk');
      }
    }
    log('Stream finished: $fullResponse');
  }
}
