import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vocal_app/pages/upload_page.dart';
import '../services/database_helper.dart';
import '../widgets/audio_player_widget.dart';
import '../services/song.dart'; // Import the asset songs

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  Future<List<Map<String, dynamic>>> getData() async {
    return await DatabaseHelper().getSongs(); // Fetch database songs
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> combinedSongs = List.from(snapshot.data!);
          combinedSongs.addAll(assetSongs.map((song) =>
          {
            'title': song.title,
            'artist': song.artist,
            'filepath': song.filePath,
            'coverImage': song.coverImage,
          }));

          return ListView.builder(
            itemCount: combinedSongs.length,
            itemBuilder: (context, index) {
              final song = combinedSongs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MusicPlayer(
                            name: song['artist'],
                            image: song['coverImage'],
                            songName: song['filepath'],
                            isAsset: song['filepath'].startsWith('assets/'),
                          ),
                    ),
                  );
                },
                child: listSong(
                  song['title'],
                  song['artist'],
                  song['coverImage'],
                ),
              );
            },
          );
        }
      },
    );
  }


  Widget listSong(String songName, String artistName, String coverImagePath) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xffD9D9D9),
        backgroundImage: coverImagePath.isNotEmpty
            ? FileImage(File(coverImagePath)) // Load the cover image
            : const AssetImage('assets/images/top_50.jpeg') as ImageProvider,
        // Default image if none
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