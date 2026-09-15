import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              buildPage(
                icon: Icons.home_repair_service,
                title: "Find Skilled Technicians",
                description:
                    "Book trusted professionals near your location instantly.",
              ),

              buildPage(
                icon: Icons.location_on,
                title: "Live Tracking",
                description: "Track technicians in real time just like Uber.",
              ),

              buildPage(
                icon: Icons.star,
                title: "Top Rated Services",
                description:
                    "Choose from highly rated electricians, plumbers and more.",
              ),
            ],
          ),

          Container(
            alignment: const Alignment(0, 0.75),
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: const WormEffect(dotHeight: 12, dotWidth: 12),
            ),
          ),

          Positioned(
            right: 20,
            top: 60,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text("Skip", style: TextStyle(fontSize: 18)),
            ),
          ),

          Positioned(
            bottom: 50,
            right: 20,
            left: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: () {
                if (isLastPage) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                } else {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Text(isLastPage ? "Get Started" : "Next"),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 140, color: Colors.blue),

          const SizedBox(height: 40),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
