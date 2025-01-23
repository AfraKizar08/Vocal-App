import 'package:flutter/material.dart';
import 'package:vocal_app/widgets/audio_player_widget.dart'; // Import the MusicPlayer class
import 'package:vocal_app/services/database_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Vocalsify',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: false, // Set to false to allow left alignment
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black12, Colors.green],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Your Favorite Vocal Tracks Await!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            // Start discovering music
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Discover Now',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Trending Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Trending Now',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        TrendingCard(
                          title: 'Arabian Night',
                          artist: 'Will Smith',
                          image: 'assets/images/arabnight.jpg',
                        ),
                        TrendingCard(
                          title: 'Tere Bin',
                          artist: 'Wahaj Ali',
                          image: 'assets/images/terebin.jpg',
                        ),
                        TrendingCard(
                          title: 'Dawasak Ewi',
                          artist: 'Piyath Rajapaksha',
                          image: 'assets/images/dawasak.jpg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Recent Tracks Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Tracks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Inside the Recent Tracks Section
                  MusicCard(
                    title: 'Arabian Vibes',
                    subtitle: 'Artist: Maher Zain',
                    songPath: 'path/to/arabian_vibes.mp3', //
                    coverImage: 'assets/images/maher.jpg', // Replace with actual cover image
                  ),
                  MusicCard(
                    title: 'Channa Meraya',
                    subtitle: 'Artist: Atif Aslam',
                    songPath: 'assets/songs/channameraya.mp3', // Replace with actual path
                    coverImage: 'assets/images/atif.jpg', // Replace with actual cover image
                  ),
                  MusicCard(
                    title: 'Harmonic Bliss',
                    subtitle: 'Artist: One Direction',
                    songPath: 'path/to/harmonic_bliss.mp3', // Replace with actual path
                    coverImage: 'assets/images/onedirection.jpg', // Replace with actual cover image
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class TrendingCard extends StatelessWidget {
  final String title;
  final String artist;
  final String image;

  const TrendingCard({
    required this.title,
    required this.artist,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.bottomLeft,
        child: Text(
          '$title\n$artist',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MusicCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String songPath; // Add song path
  final String coverImage; // Add cover image path

  const MusicCard({
    required this.title,
    required this.subtitle,
    required this.songPath,
    required this.coverImage,
    Key? key,
  }) : super(key: key);

  @override
  _MusicCardState createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(widget.coverImage), // Display cover image
          backgroundColor: Colors.green,
        ),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.green),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicPlayer(
                      name: widget.subtitle.split(': ')[1], // Extract artist name
                      image: widget.coverImage,
                      songName: widget.songPath,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> getData() async {
  return await DatabaseHelper().getSongs();
}

@override
Widget build(BuildContext context) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: getData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        final songs = snapshot.data;
        return ListView.builder(
          itemCount: songs?.length,
          itemBuilder: (context, index) {
            final song = songs?[index];
            return ListTile(
              title: Text(song?['title']),
              subtitle: Text(song?['artist']),
            );
          },
        );
      }
    },
  );
}
