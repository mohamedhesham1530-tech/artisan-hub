import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../notifications/notifications_screen.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  File? profileImage;

  @override
  void initState() {
    super.initState();
    loadProfileImage();
  }

  Future<void> loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();

    final imagePath = prefs.getString("profile_image");

    if (imagePath != null && mounted) {
      setState(() {
        profileImage = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xff2563EB),

            backgroundImage: profileImage != null
                ? FileImage(profileImage!)
                : null,

            child: profileImage == null
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Hello Mohamed 👋",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 5),

                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.red),

                    SizedBox(width: 4),

                    Text(
                      "Alexandria, Egypt",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          InkWell(
            borderRadius: BorderRadius.circular(15),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },

            child: Container(
              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),

              child: const Icon(Icons.notifications_none),
            ),
          ),
        ],
      ),
    );
  }
}
