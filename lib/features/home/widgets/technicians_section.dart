import 'package:flutter/material.dart';

import '../../orders/create_order_screen.dart';
import '../../technicians/technician_details_screen.dart';

class TechniciansSection extends StatelessWidget {
  const TechniciansSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Top Rated Technicians",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 15),

        _card(
          context,
          "Ahmed Hassan",
          "Electrician",
          "4.9",
          Icons.electrical_services,
        ),

        _card(context, "Mohamed Ali", "Plumber", "4.8", Icons.plumbing),

        _card(context, "Mahmoud Samir", "Carpenter", "4.7", Icons.carpenter),
      ],
    );
  }

  Widget _card(
    BuildContext context,
    String name,
    String job,
    String rating,
    IconData icon,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                TechnicianDetailsScreen(name: name, job: job, rating: rating),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10),
          ],
        ),

        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xff2563EB).withOpacity(.15),

              child: Icon(icon, color: const Color(0xff2563EB)),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(job, style: const TextStyle(color: Colors.grey)),

                  const SizedBox(height: 5),

                  const Text(
                    "5 Years Experience",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),

                    const SizedBox(width: 3),

                    Text(
                      rating,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                SizedBox(
                  height: 35,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2563EB),
                    ),

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CreateOrderScreen(serviceName: job),
                        ),
                      );
                    },

                    child: const Text(
                      "Book",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
