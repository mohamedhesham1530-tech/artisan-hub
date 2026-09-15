import 'package:flutter/material.dart';

import '../../../shared/widgets/service_card.dart';
import '../../services/service_details_screen.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Popular Services",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 15),

        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
          children: [
            ServiceCard(
              icon: Icons.electrical_services,
              title: "Electrician",
              onTap: () => _openService(context, "Electrician"),
            ),

            ServiceCard(
              icon: Icons.plumbing,
              title: "Plumber",
              onTap: () => _openService(context, "Plumber"),
            ),

            ServiceCard(
              icon: Icons.carpenter,
              title: "Carpenter",
              onTap: () => _openService(context, "Carpenter"),
            ),

            ServiceCard(
              icon: Icons.format_paint,
              title: "Painter",
              onTap: () => _openService(context, "Painter"),
            ),

            ServiceCard(
              icon: Icons.ac_unit,
              title: "AC Repair",
              onTap: () => _openService(context, "AC Repair"),
            ),

            ServiceCard(
              icon: Icons.videocam,
              title: "CCTV",
              onTap: () => _openService(context, "CCTV"),
            ),
          ],
        ),
      ],
    );
  }

  void _openService(BuildContext context, String serviceName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceDetailsScreen(serviceName: serviceName),
      ),
    );
  }
}
