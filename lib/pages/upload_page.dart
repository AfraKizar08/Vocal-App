import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vocal_app/pages/home_page.dart';
import 'package:vocal_app/services/database_helper.dart';
import 'package:vocal_app/pages/musiclist.dart';

import '../main.dart';

class UploadSong extends StatefulWidget {
  const UploadSong({super.key});

  @override
  State<UploadSong> createState() => _UploadSongState();
}

class _UploadSongState extends State<UploadSong> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  String? audioFilePath;
  String? coverImagePath;


  @override
  void dispose() {
    titleController.dispose();
    artistController.dispose();
    super.dispose();
  }

  Future<void> selectAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        audioFilePath = result.files.single.path!;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected Audio: ${result.files.single.name}')),
      );
    }
  }

  Future<void> selectCoverImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        coverImagePath = result.files.single.path!;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected Cover Image: ${result.files.single.name}')),
      );
    }
  }

  Future<void> saveSong() async {
    if (audioFilePath != null && coverImagePath != null) {
      // Save to local database
      await DatabaseHelper().insertSong({
        'title': titleController.text,
        'artist': artistController.text,
        'filepath': audioFilePath,
        'coverImage': coverImagePath,
      });
      print("Song saved: ${titleController.text}"); // Debugging line
      // Optionally, navigate back to the music list

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            MusicList()), // Replace with your target screen
      );
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select audio and cover image.')),
      );
    }
  }

  Widget _buildSelectedFileCard(String title, String filePath) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(filePath),
        trailing: const Icon(Icons.file_present, color: Colors.green),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Song Title'),
            ),
            TextField(
              controller: artistController,
              decoration: const InputDecoration(labelText: 'Artist Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectAudioFile,
              child: const Text('Select Audio File'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: selectCoverImage,
              child: const Text('Select Cover Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveSong,
              child: const Text('Save Song'),
            ),
            const SizedBox(height: 20),
            if (audioFilePath != null)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: const Icon(Icons.audiotrack, color: Colors.green),
                  title: Text('Selected Audio: ${titleController.text}'),
                  subtitle: Text(audioFilePath!.split('/').last),
                ),
              ),

            // Display selected cover image
            if (coverImagePath != null)
              Column(
                children: [
                  Image.file(
                    File(coverImagePath!),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),

                ],
              ),

          ],
        ),
      ),
    );
  }
}