import 'package:flutter/material.dart';

class AudioProcessingService with ChangeNotifier {
  Future<void> extractVocals(String filePath) async {
    // Simulate processing or use a real API
    print('Processing file: $filePath');
    await Future.delayed(Duration(seconds: 3)); // Simulated delay
    print('Vocals extracted successfully!');
  }
}
