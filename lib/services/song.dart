// songs.dart
class Song {
  final String title;
  final String artist;
  final String filePath;
  final String coverImage;

  Song({
    required this.title,
    required this.artist,
    required this.filePath,
    required this.coverImage,
  });
}

List<Song> assetSongs = [
  Song(
    title: 'Tum Hi Ho',
    artist: 'Arjit Singh',
    filePath: 'assets/songs/song1.mp3',
    coverImage: 'assets/images/cover1.jpg',
  ),
  Song(
    title: 'Song 2',
    artist: 'Artist 2',
    filePath: 'assets/songs/song2.mp3',
    coverImage: 'assets/images/cover2.jpg',
  ),
  // Add more songs here...
];