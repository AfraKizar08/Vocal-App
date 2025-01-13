import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioFilePath;

  AudioPlayerWidget({required this.audioFilePath});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void playAudio() {
    // Use DeviceFileSource for local audio files
    _audioPlayer.play(DeviceFileSource(widget.audioFilePath));
  }

  void stopAudio() {
    _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: playAudio,
        ),
        IconButton(
          icon: Icon(Icons.stop),
          onPressed: stopAudio,
        ),
      ],
    );
  }
}
