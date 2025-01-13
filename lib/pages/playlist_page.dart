import 'package:flutter/material.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({Key? key}) : super(key: key);

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
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Explore and listen to your playlists',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            PlaylistCard(
              playlistName: 'Relaxing Vibes',
              trackCount: 15,
              coverImage: 'assets/relaxing_vibes.jpeg',
            ),
            PlaylistCard(
              playlistName: 'Workout Hits',
              trackCount: 20,
              coverImage: 'assets/workout_hits.jpeg',
            ),
            PlaylistCard(
              playlistName: 'Chill Beats',
              trackCount: 10,
              coverImage: 'assets/chill_beats.jpeg',
            ),
            PlaylistCard(
              playlistName: 'Top 50',
              trackCount: 50,
              coverImage: 'assets/top_50.jpeg',
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistCard extends StatefulWidget {
  final String playlistName;
  final int trackCount;
  final String coverImage;

  const PlaylistCard({
    Key? key,
    required this.playlistName,
    required this.trackCount,
    required this.coverImage,
  }) : super(key: key);

  @override
  _PlaylistCardState createState() => _PlaylistCardState();
}

class _PlaylistCardState extends State<PlaylistCard> {
  bool isLiked = false; // State to track if the playlist is liked

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to playlist details
      },
      child: Container(
        height: 120, // Fixed height
        width: double.infinity, // Ensure full width
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey, // Solid background color
          borderRadius: BorderRadius.circular(12), // Rounded corners
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
                widget.coverImage,
                width: 100, // Fixed width for image
                height: 120, // Match container height
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
                    widget.playlistName,
                    style: const TextStyle(
                      fontSize: 18, // Font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.trackCount} tracks',
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
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.deepPurple,
                size: 28, // Icon size
              ),
              onPressed: () {
                // Handle play action
                print('Playing ${widget.playlistName}');
              },
            ),
            IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.black,
                size: 28, // Icon size
              ),
              onPressed: () {
                setState(() {
                  isLiked = !isLiked; // Toggle like state
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}