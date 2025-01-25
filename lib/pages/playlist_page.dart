import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({Key? key}) : super(key: key);

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  List<Map<String, dynamic>> playlists = [
    {
      'playlistName': 'Relaxing Vibes',
      'trackCount': 15,
      'coverImage': 'assets/images/relaxing_vibes.jpeg',
      'audioFile': 'assets/audio/relaxing_vibes.mp3',
    },
    {
      'playlistName': 'Workout Hits',
      'trackCount': 20,
      'coverImage': 'assets/images/workout_hits.jpeg',
      'audioFile': 'assets/audio/workout_hits.mp3',
    },
    {
      'playlistName': 'Chill Beats',
      'trackCount': 10,
      'coverImage': 'assets/images/chill_beats.jpeg',
      'audioFile': 'assets/audio/chill_beats.mp3',
    },
    {
      'playlistName': 'Top 10',
      'trackCount': 10,
      'coverImage': 'assets/images/top_50.jpeg',
      'audioFile': 'assets/audio/top_50.mp3',
    },
  ];

  List<Map<String, dynamic>> favoritePlaylists = [];

  void _removePlaylist(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this playlist?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  playlists.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  void _addToFavorites(Map<String, dynamic> playlist) {
    if (!favoritePlaylists.contains(playlist)) {
      setState(() {
        favoritePlaylists.add(playlist);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Playlists',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover Your Favorite Tunes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Explore and listen to your playlists',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(playlists.length, (index) {
                return PlaylistCard(
                  playlist: playlists[index],
                  onDelete: () => _removePlaylist(index),
                  onFavorite: () => _addToFavorites(playlists[index]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistCard extends StatefulWidget {
  final Map<String, dynamic> playlist;
  final VoidCallback onDelete;
  final VoidCallback onFavorite;

  const PlaylistCard({
    Key? key,
    required this.playlist,
    required this.onDelete,
    required this.onFavorite,
  }) : super(key: key);

  @override
  _PlaylistCardState createState() => _PlaylistCardState();
}

class _PlaylistCardState extends State<PlaylistCard> {
  bool isLiked = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlay() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(widget.playlist['audioFile']));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 120,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                widget.playlist['coverImage'],
                width: 100,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.playlist['playlistName'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.playlist['trackCount']} tracks',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
                size: 28,
              ),
              onPressed: _togglePlay,
            ),
            IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.black,
                size: 28,
              ),
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
                widget.onFavorite();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.black,
                size: 28,
              ),
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
