import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

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
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _playAudio();
  }

  Future<void> _playAudio() async {
    try {
      if (widget.isAsset) {
        await _audioPlayer.play(AssetSource(widget.songName));
      } else {
        await _audioPlayer.play(DeviceFileSource(widget.songName));
      }
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> _downloadAudio() async {
    try {
      // Get the directory to save the downloaded file
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${widget.songName.split('/').last}';

      if (widget.isAsset) {
        // Copy the file from assets
        final assetData = await DefaultAssetBundle.of(context).load(widget.songName);
        final file = File(filePath);
        await file.writeAsBytes(assetData.buffer.asUint8List());
      } else {
        // Copy the file from the local device
        final originalFile = File(widget.songName);
        await originalFile.copy(filePath);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloaded to $filePath')),
      );
    } catch (e) {
      print("Error downloading file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to download file')),
      );
    }
  }

  Future<void> _addToPlaylist(BuildContext context) async {
    TextEditingController playlistController = TextEditingController();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: playlistController,
                decoration: const InputDecoration(
                  labelText: 'Playlist Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final playlistName = playlistController.text.trim();
                  if (playlistName.isNotEmpty) {
                    // Save the song to the playlist in database (implement logic here)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to playlist: $playlistName')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add to Playlist'),
              ),
            ],
          ),
        );
      },
    );
  }

  void playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _playAudio();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Cover Image
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                image: DecorationImage(
                  image: widget.isAsset
                      ? AssetImage(widget.image) as ImageProvider
                      : FileImage(File(widget.image)),
                  fit: BoxFit.cover,
                ),
              ),
              height: 300,
              width: 300,
            ),
            const SizedBox(height: 20),
            // Song Name
            Text(
              widget.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Slider
            Slider(
              value: _position.inSeconds.toDouble(),
              min: 0.0,
              max: _duration.inSeconds.toDouble(),
              activeColor: Colors.deepPurple,
              inactiveColor: Colors.grey,
              onChanged: (value) async {
                await _audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
            // Duration Display
            Text(
              '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')} / ${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous, color: Colors.white, size: 30),
                  onPressed: () {
                    // Implement previous track logic
                  },
                ),
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: playPause,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next, color: Colors.white, size: 30),
                  onPressed: () {
                    // Implement next track logic
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _downloadAudio,
                  icon: const Icon(Icons.download),
                  label: const Text('Download'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _addToPlaylist(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Add to Playlist'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
