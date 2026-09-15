import 'package:flutter/material.dart';

import '../../data/favorites_data.dart';
import '../orders/create_order_screen.dart';

class TechnicianDetailsScreen extends StatefulWidget {
  final String name;
  final String job;
  final String rating;

  const TechnicianDetailsScreen({
    super.key,
    required this.name,
    required this.job,
    required this.rating,
  });

  @override
  State<TechnicianDetailsScreen> createState() =>
      _TechnicianDetailsScreenState();
}

class _TechnicianDetailsScreenState extends State<TechnicianDetailsScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();

    isFavorite = FavoritesData.favorites.contains(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Technician Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xff2563EB),
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),

            const SizedBox(height: 15),

            Text(
              widget.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            Text(
              widget.job,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber),

                const SizedBox(width: 5),

                Text(
                  widget.rating,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFavorite ? Colors.red : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });

                  if (isFavorite) {
                    FavoritesData.favorites.add(widget.name);
                  } else {
                    FavoritesData.favorites.remove(widget.name);
                  }
                },

                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),

                label: Text(
                  isFavorite ? "Remove Favorite" : "Add To Favorites",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            _infoCard(Icons.work, "Experience", "5 Years"),

            _infoCard(Icons.location_on, "Distance", "1.2 KM"),

            _infoCard(Icons.check_circle, "Completed Orders", "125 Orders"),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Calling Technician...")),
                  );
                },

                icon: const Icon(Icons.call, color: Colors.white),

                label: const Text(
                  "Call Technician",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CreateOrderScreen(serviceName: widget.job),
                    ),
                  );
                },

                icon: const Icon(Icons.calendar_month, color: Colors.white),

                label: const Text(
                  "Book Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [
          Icon(icon, color: const Color(0xff2563EB)),

          const SizedBox(width: 15),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Text(value),
        ],
      ),
    );
  }
}
