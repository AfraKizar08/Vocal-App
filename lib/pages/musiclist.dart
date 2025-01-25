import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocal_app/pages/home_page.dart';
import 'package:vocal_app/pages/upload_page.dart';
import '../services/database_helper.dart';
import '../widgets/audio_player_widget.dart';
import '../services/song.dart'; // Import the asset songs
import '../providers/favourites_provider.dart';

class MusicList extends ConsumerStatefulWidget {
  const MusicList({super.key});

  @override
  ConsumerState<MusicList> createState() => _MusicListState();
}

class _MusicListState extends ConsumerState<MusicList> {
  Future<List<Map<String, dynamic>>> getData() async {
    // Fetch songs from the local SQLite database
    return await DatabaseHelper().getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(
          'Music List',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xffD2CEF6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Upload song FAB button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UploadSong()),
          );
        },
        backgroundColor: Color(0xffD2CEF6),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Combine database songs with asset songs
            List<Map<String, dynamic>> combinedSongs = List.from(snapshot.data!);
            combinedSongs.addAll(assetSongs.map((song) => {
              'title': song.title,
              'artist': song.artist,
              'filepath': song.filePath,
              'coverImage': song.coverImage,
            }).toList());

            return ListView.builder(
              itemCount: combinedSongs.length,
              itemBuilder: (context, index) {
                final song = combinedSongs[index];
                bool isLiked = ref.watch(favouritesProvider).any((fav) => fav['title'] == song['title']);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayer(
                          name: song['artist'], // Use the artist from the database or asset
                          image: song['coverImage'],
                          songName: song['filepath'],
                        ),
                      ),
                    );
                  },
                  child: MusicCard(
                    title: song['title'],
                    subtitle: song['artist'],
                    songPath: song['filepath'],
                    coverImage: song['coverImage'],
                    isLiked: isLiked, // Pass the isLiked state// Get the cover image path
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget listSong(String songName, String artistName, String coverImagePath) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xffD9D9D9),
        backgroundImage: coverImagePath.isNotEmpty
            ? FileImage(File(coverImagePath)) // Load the cover image
            : const AssetImage('assets/images/top_50.jpeg') as ImageProvider, // Default image if none
        child: coverImagePath.isEmpty
            ? const Icon(Icons.music_note,
            size: 25, color: Color.fromARGB(255, 221, 46, 33))
            : null,
      ),
      title: Text(songName),
      subtitle: Text(artistName),
      trailing: const CircleAvatar(
        radius: 15,
        backgroundColor: Color.fromARGB(255, 221, 46, 33),
        child: Icon(Icons.play_arrow_rounded, color: Colors.white),
      ),
    );
  }
}