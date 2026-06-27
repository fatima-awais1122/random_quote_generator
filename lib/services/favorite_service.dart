import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String key = "favorite_quotes";

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(key) ?? [];
  }

  static Future<void> saveFavorite(String quote, String author) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favorites = prefs.getStringList(key) ?? [];

    String item = jsonEncode({"quote": quote, "author": author});

    if (!favorites.contains(item)) {
      favorites.add(item);
      await prefs.setStringList(key, favorites);
    }
  }

  static Future<void> removeFavorite(String item) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favorites = prefs.getStringList(key) ?? [];

    favorites.remove(item);

    await prefs.setStringList(key, favorites);
  }
}
