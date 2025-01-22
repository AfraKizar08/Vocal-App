import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritesNotifier extends StateNotifier<List<Map<String, String>>> {
  FavouritesNotifier() : super([]);

  void addFavourite(Map<String, String> item) {
    if (!state.any((fav) => fav['title'] == item['title'])) {
      state = [...state, item];
    }
  }

  void removeFavourite(String title) {
    state = state.where((item) => item['title'] != title).toList();
  }

  bool isFavourite(String title) {
    return state.any((item) => item['title'] == title);
  }
}

final favouritesProvider =
StateNotifierProvider<FavouritesNotifier, List<Map<String, String>>>(
      (ref) => FavouritesNotifier(),
);
