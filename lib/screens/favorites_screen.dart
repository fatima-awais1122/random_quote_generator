import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/favorite_service.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favs = await FavoriteService.getFavorites();
    setState(() {
      favorites = favs;
    });
  }

  Future<void> removeFavorite(String item) async {
    await FavoriteService.removeFavorite(item);
    loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text("Favorites"),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "No favorites yet ❤️",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final item = favorites[index];
                final data = jsonDecode(item);
                final quote = data["quote"];
                final author = data["author"];

                bool isFavorite = true; // 👈 default red

                return Card(
                  color: const Color(0xFF1E293B),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      quote,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    subtitle: Text(
                      "- $author",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    trailing: StatefulBuilder(
                      builder: (context, setStateIcon) {
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              removeFavorite(item);
                            }
                            setStateIcon(() {
                              isFavorite = !isFavorite;
                            });
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
