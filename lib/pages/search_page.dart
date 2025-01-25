import 'package:flutter/material.dart';
import '../services/song.dart'; // Import the asset songs
import 'package:vocal_app/widgets/audio_player_widget.dart'; // Adjust the path as necessary

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    List<Song> filteredSongs = assetSongs
        .where((song) => song.title.toLowerCase().contains(query.toLowerCase()) ||
        song.artist.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Music'),
      ),
    body: Column(
    children: [
    TextField(
    decoration: const InputDecoration(hintText: 'Search songs...'),
    onChanged: (value) {
    setState(() {
    query = value;
    });
    },
    ),
    Expanded(
    child: ListView.builder(
    itemCount: filteredSongs.length,
    itemBuilder: (context, index) {
    return ListTile(
    title: Text(filteredSongs[index].title),
    subtitle: Text(filteredSongs[index].artist),
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => MusicPlayer(
      name: 'Atif Aslam',
      image: 'assets/images/atif.jpg',
      songName: 'assets/songs/channa_meraya.mp3',
      isAsset: true, // Specify as an asset
    ),
    ),
    );
    },
    );
    },
    ),
    ),
    ],
    ),
    );
  }
}