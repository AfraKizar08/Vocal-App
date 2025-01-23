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
    title: 'Channa Meraya',
    artist: 'Atif Aslam',
    filePath: 'assets/songs/channameraya.mp3',
    coverImage: 'assets/images/atif.jpg',
  ),
  Song(
    title: 'Song 2',
    artist: 'Artist 2',
    filePath: 'assets/songs/song2.mp3',
    coverImage: 'assets/images/cover2.jpg',
  ),
  // Add more songs here...
];