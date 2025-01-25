import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocal_app/providers/favourites_provider.dart';
import 'package:vocal_app/widgets/audio_player_widget.dart'; // Import the MusicPlayer class
import 'package:vocal_app/services/database_helper.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: DatabaseHelper().getSongs(), // Fetch recent tracks
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final songs = snapshot.data ?? [];
                        if (songs.isEmpty) {
                          return Center(child: Text('No recent tracks available.'));
                        }
                        final limitedSongs = songs.take(3).toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: limitedSongs.length,
                          itemBuilder: (context, index) {
                            final song = limitedSongs[index];
                            return MusicCard(
                              title: song['title'],
                              subtitle: song['artist'],
                              songPath: song['filepath'],
                              coverImage: song['coverImage'],
                              isLiked: ref.watch(favouritesProvider).any((fav) => fav['title'] == song['title']),
                            );
                          },
                        );
                      }
                    },
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

class MusicCard extends ConsumerWidget {
  final String title;
  final String subtitle;
  final String songPath; // Add song path
  final String coverImage; // Add cover image path
  final bool isLiked;

  const MusicCard({
    required this.title,
    required this.subtitle,
    required this.songPath,
    required this.coverImage,
    required this.isLiked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLiked = ref.watch(favouritesProvider).any((fav) => fav['title'] == title);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: coverImage.isNotEmpty
              ? FileImage(File(coverImage)) // Load the cover image
              : const AssetImage('assets/images/default_cover.png') as ImageProvider, // Default image if none
          backgroundColor: Colors.green,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.green),
              onPressed: () {
                // Play the song
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicPlayer(
                      name: title,
                      image: coverImage,
                      songName: songPath,
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
                if (isLiked) {
                  // Remove from favorites
                  ref.read(favouritesProvider.notifier).removeFavourite(title);
                } else {
                  // Add to favorites
                  ref.read(favouritesProvider.notifier).addFavourite({
                    'title': title,
                    'subtitle': subtitle,
                  });
                }
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