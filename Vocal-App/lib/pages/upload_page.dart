import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vocal_app/services/database_helper.dart';
import 'package:path/path.dart';

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

      // Optionally, navigate back to the music list
      Navigator.pop(context);
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select audio and cover image.')),
      );
    }
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
              Text('Selected Audio: $audioFilePath'),
            if (coverImagePath != null)
              Text('Selected Cover Image: $coverImagePath'),
          ],
        ),
      ),
    );
  }
}