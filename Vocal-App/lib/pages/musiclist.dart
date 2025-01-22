import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:vocal_app/pages/upload_page.dart';
import '../services/database_helper.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final song = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayer(
                          song['title'], // Use the title from the database
                          song['filepath'], // Use the file path from the database
                        ),
                      ),
                    );
                  },
                  child: listSong(
                    song['title'],
                    song['artist'],
                    song['coverImage'], // Get the cover image path
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
            : const AssetImage('assets/default_cover.png') as ImageProvider, // Default image if none
        child: coverImagePath.isEmpty
            ? const Icon(Icons.music_note, size: 25, color: Color.fromARGB(255, 221, 46, 33))
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