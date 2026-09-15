import 'package:flutter/material.dart';

import '../../offers/offer_details_screen.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Special Offers",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 15),

        _offerCard(
          context,
          title: "20% OFF On AC Repair",
          discount: "20%",
          description:
              "Get 20% discount on all AC repair and maintenance services for a limited time.",
          colors: const [Colors.orange, Colors.deepOrange],
        ),

        const SizedBox(height: 15),

        _offerCard(
          context,
          title: "15% OFF On Plumbing",
          discount: "15%",
          description:
              "Save money on plumbing services and home water maintenance.",
          colors: const [Colors.blue, Colors.indigo],
        ),

        const SizedBox(height: 15),

        _offerCard(
          context,
          title: "25% OFF On Electrical Work",
          discount: "25%",
          description:
              "Professional electricians with a special 25% discount offer.",
          colors: const [Colors.green, Colors.teal],
        ),
      ],
    );
  }

  Widget _offerCard(
    BuildContext context, {
    required String title,
    required String discount,
    required String description,
    required List<Color> colors,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OfferDetailsScreen(
              title: title,
              description: description,
              discount: discount,
            ),
          ),
        );
      },

      child: Container(
        height: 140,
        width: double.infinity,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),

          gradient: LinearGradient(colors: colors),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Icon(Icons.local_offer, color: Colors.white, size: 40),

              const SizedBox(height: 10),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Tap To View Details",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
