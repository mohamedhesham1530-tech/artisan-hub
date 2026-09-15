import 'dart:io';

import 'package:flutter/material.dart';
import '../../data/order_data.dart';
import '../../data/notification_data.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;
  final int index;

  const OrderDetailsScreen({
    super.key,
    required this.order,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Order Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 220,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: order.imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(order.imagePath!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.image_not_supported,
                          size: 70,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "No Image Uploaded",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
            ),

            const SizedBox(height: 20),

            _infoCard(Icons.home_repair_service, "Service", order.service),

            _infoCard(Icons.info, "Status", order.status),

            _infoCard(Icons.phone, "Phone", order.phone),

            _infoCard(Icons.location_on, "Address", order.address),

            _infoCard(Icons.description, "Description", order.description),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                onPressed: () {
                  NotificationData.notifications.insert(
                    0,
                    "${order.service} order cancelled successfully",
                  );
                  OrderData.orders.removeAt(index);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Order Cancelled Successfully"),
                    ),
                  );

                  Navigator.pop(context);
                },

                icon: const Icon(Icons.delete, color: Colors.white),

                label: const Text(
                  "Cancel Order",
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
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(icon, color: const Color(0xff2563EB)),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 5),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
