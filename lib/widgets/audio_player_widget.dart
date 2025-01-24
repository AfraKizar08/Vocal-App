import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayer extends StatefulWidget {
  final String name;
  final String image;
  final String songName;
  final bool isAsset;

  const MusicPlayer({
    Key? key,
    required this.name,
    required this.image,
    required this.songName,
    required this.isAsset,
  }) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late final AudioPlayer _audioPlayer;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        _position = Duration.zero;
      });
    });

    play();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void play() async {
    if (widget.isAsset) {
      await _audioPlayer.play(AssetSource(widget.songName));
    } else {
      await _audioPlayer.play(DeviceFileSource(widget.songName));
    }
  }

  void downloadSong() {
    // Simulating a download feature
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Song downloaded to device')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: downloadSong,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Large Cover Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(widget.image, height: 300, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            // Song Title and Artist
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // Progress Slider
            Slider(
              value: _position.inSeconds.toDouble(),
              min: 0,
              max: _duration.inSeconds.toDouble(),
              onChanged: (value) async {
                await _audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 40,
                  onPressed: () {
                    // Add previous track logic
                  },
                ),
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  iconSize: 60,
                  onPressed: playPause,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 40,
                  onPressed: () {
                    // Add next track logic
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Add to Playlist Button
            ElevatedButton.icon(
              onPressed: () {
                // Add to playlist logic
              },
              icon: const Icon(Icons.add),
              label: const Text('Add to Playlist'),
            ),
          ],
        ),
      ),
    );
  }
}
