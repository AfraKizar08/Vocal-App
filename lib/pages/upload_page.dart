import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../services/audio_processing_service.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? filePath;

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path!;
      });

      // Process file to extract vocals
      await Provider.of<AudioProcessingService>(context, listen: false)
          .extractVocals(filePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Music'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Upload Your Favorite Track!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select a music file to extract vocals and enhance your listening experience.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: selectFile,
              icon: const Icon(Icons.upload_file, color: Colors.white),
              label: const Text(
                'Select a Music File',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (filePath != null)
              Column(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 48,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'File Selected:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    filePath!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Processing vocals... Please wait!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                  ),
                ],
              ),
            if (filePath == null)
              const Icon(
                Icons.music_note,
                color: Colors.black,
                size: 100,
              ),
          ],
        ),
      ),
    );
  }
}
