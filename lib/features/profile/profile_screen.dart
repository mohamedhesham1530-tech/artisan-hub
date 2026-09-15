import 'dart:io';
import '../favorites/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme_provider.dart';
import '../auth/login_screen.dart';
import '../orders/orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "Mohamed Hesham";
  String userEmail = "test@test.com";

  File? profileImage;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString("user_name") ?? "Mohamed Hesham";

      final imagePath = prefs.getString("profile_image");

      if (imagePath != null) {
        profileImage = File(imagePath);
      }
    });
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("user_name", userName);

    if (profileImage != null) {
      await prefs.setString("profile_image", profileImage!.path);
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });

      await saveProfile();
    }
  }

  Future<void> editProfile() async {
    final controller = TextEditingController(text: userName);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  userName = controller.text;
                });

                await saveProfile();

                if (!mounted) return;

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );

    if (result == true) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove("token");

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  Widget profileTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xff2563EB)),
        title: Text(title),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void showAboutApp() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("About App"),
        content: const Text(
          "Artisan Hub is a smart platform that connects customers with skilled technicians nearby. Users can create service requests, upload images, select locations on the map, track orders and manage services easily.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void showNotifications() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Notifications"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.notifications_none, size: 60, color: Colors.blue),
            SizedBox(height: 15),
            Text("No new notifications yet.", textAlign: TextAlign.center),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void showContactUs() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Contact Us"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("📧 artisanhub@app.com", textAlign: TextAlign.center),
            SizedBox(height: 12),
            Text("📞 +20 100 000 0000", textAlign: TextAlign.center),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: const Color(0xff2563EB),

                  backgroundImage: profileImage != null
                      ? FileImage(profileImage!)
                      : null,

                  child: profileImage == null
                      ? const Icon(Icons.person, color: Colors.white, size: 55)
                      : null,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                userName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(userEmail, style: const TextStyle(color: Colors.grey)),

              const SizedBox(height: 25),

              profileTile(
                icon: Icons.edit,
                title: "Edit Profile",
                onTap: editProfile,
              ),

              profileTile(
                icon: Icons.receipt_long,
                title: "My Orders",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OrdersScreen()),
                  );
                },
              ),

              profileTile(
                icon: Icons.notifications,
                title: "Notifications",
                onTap: showNotifications,
              ),

              profileTile(
                icon: Icons.dark_mode,
                title: "Dark Mode",
                trailing: Switch(
                  value: themeProvider.isDark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ),
              profileTile(
                icon: Icons.favorite,
                title: "My Favorites",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                  );
                },
              ),
              profileTile(
                icon: Icons.info,
                title: "About App",
                onTap: showAboutApp,
              ),

              profileTile(
                icon: Icons.support_agent,
                title: "Contact Us",
                onTap: showContactUs,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: logout,
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    "Logout",
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
      ),
    );
  }
}
