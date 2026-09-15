import 'package:flutter/material.dart';

import '../../data/favorites_data.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Favorites",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: FavoritesData.favorites.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),

                  SizedBox(height: 15),

                  Text(
                    "No Favorites Yet",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Add technicians to favorites",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),

              itemCount: FavoritesData.favorites.length,

              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),

                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.red,

                        child: Icon(Icons.favorite, color: Colors.white),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Text(
                          FavoritesData.favorites[index],

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            FavoritesData.favorites.removeAt(index);
                          });
                        },

                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
