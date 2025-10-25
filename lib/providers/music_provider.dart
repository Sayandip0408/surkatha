import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/song.dart';

class MusicProvider extends ChangeNotifier {
  List<Song> songs = [];
  final Set<String> likedIds = {};
  ThemeMode themeMode = ThemeMode.light;

  MusicProvider() {
    _loadMockSongs();
  }

  void _loadMockSongs() {
    songs = List.generate(12, (i) {
      return Song(
        id: 'song_$i',
        title: 'Song Title ${i + 1}',
        artist: 'Artist ${i + 1}',
        albumArtPath: null,
        duration: Duration(minutes: 3, seconds: 10 + i),
      );
    });
  }

  // Likes
  Future<void> loadSavedLikes() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('liked_songs') ?? [];
    likedIds
      ..clear()
      ..addAll(saved);
    notifyListeners();
  }

  Future<void> toggleLike(String id) async {
    if (likedIds.contains(id))
      likedIds.remove(id);
    else {
      likedIds.add(id);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('liked_songs', likedIds.toList());
  }

  bool isLiked(String id) => likedIds.contains(id);

  List<Song> get likedSongs =>
      songs.where((s) => likedIds.contains(s.id)).toList();

  Future<void> loadThemeModeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final t = prefs.getString('theme_mode') ?? 'light';
    themeMode = t == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'theme_mode',
      mode == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}
