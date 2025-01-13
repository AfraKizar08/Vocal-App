import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Music',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                hintText: 'Search for tracks, artists, or albums...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                // Perform search action
              },
            ),
            const SizedBox(height: 20),

            // Trending Section
            const Text(
              'Trending Searches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: const [
                TrendingChip(label: 'Acoustic Vibes'),
                TrendingChip(label: 'Vocal Bliss'),
                TrendingChip(label: 'Melody Vocals'),
                TrendingChip(label: 'Pure Acapella'),
                TrendingChip(label: 'Harmonic Melody'),
                TrendingChip(label: 'John Doe Hits'),
              ],
            ),
            const SizedBox(height: 20),

            // Placeholder or Search Result Info
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.music_note, size: 80, color: Colors.deepPurple),
                    const SizedBox(height: 10),
                    const Text(
                      'Search for your favorite vocals!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingChip extends StatelessWidget {
  final String label;

  const TrendingChip({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.deepPurple,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }
}
