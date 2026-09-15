import 'package:flutter/material.dart';
import '../orders/create_order_screen.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String serviceName;

  const ServiceDetailsScreen({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color(0xff2563EB),

            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                serviceName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff1E3A8A), Color(0xff2563EB)],
                  ),
                ),

                child: Stack(
                  children: [
                    Positioned(
                      top: -30,
                      right: -30,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white12,
                      ),
                    ),

                    Positioned(
                      bottom: -20,
                      left: -20,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white10,
                      ),
                    ),

                    const Center(
                      child: Icon(
                        Icons.home_repair_service,
                        size: 110,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),

                        SizedBox(width: 5),

                        Text(
                          "4.9",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        Spacer(),

                        Icon(Icons.access_time, color: Colors.blue),

                        SizedBox(width: 5),

                        Text("15 Min Arrival"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.attach_money, color: Colors.green),

                        SizedBox(width: 10),

                        Text(
                          "Starting From 100 EGP",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "$serviceName professionals are available 24/7. "
                    "Book trusted experts near your location with real-time tracking and secure service requests.",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Included Features",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  _feature(Icons.check_circle, "Professional Technician"),

                  _feature(Icons.check_circle, "Fast Response"),

                  _feature(Icons.check_circle, "Live Tracking"),

                  _feature(Icons.check_circle, "Customer Support"),

                  _feature(Icons.check_circle, "Verified Professionals"),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),

        child: SizedBox(
          height: 60,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2563EB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateOrderScreen(serviceName: serviceName),
                ),
              );
            },

            child: const Text(
              "Book Now",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _feature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),

          const SizedBox(width: 10),

          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
