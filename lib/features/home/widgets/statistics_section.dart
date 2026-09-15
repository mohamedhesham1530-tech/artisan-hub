import 'package:flutter/material.dart';
import '../../../data/order_data.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final totalOrders = OrderData.orders.length;

    final pendingOrders = OrderData.orders
        .where((e) => e.status == "Pending")
        .length;

    final completedOrders = OrderData.orders
        .where((e) => e.status == "Completed")
        .length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff2563EB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item("Orders", totalOrders.toString()),
          _item("Pending", pendingOrders.toString()),
          _item("Done", completedOrders.toString()),
        ],
      ),
    );
  }

  Widget _item(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
