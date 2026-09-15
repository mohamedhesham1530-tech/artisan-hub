import 'package:flutter/material.dart';

import '../../../data/order_data.dart';
import '../../orders/order_details_screen.dart';

class RecentOrdersSection extends StatelessWidget {
  const RecentOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (OrderData.orders.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Orders",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        ...List.generate(
          OrderData.orders.length > 3
              ? 3
              : OrderData.orders.length,
          (index) {
            final order =
                OrderData.orders.reversed.toList()[index];

            return Container(
              margin:
                  const EdgeInsets.only(bottom: 12),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor:
                      Color(0xff2563EB),
                  child: Icon(
                    Icons.home_repair_service,
                    color: Colors.white,
                  ),
                ),

                title: Text(order.service),

                subtitle: Text(order.status),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),

                onTap: () {
                  final realIndex =
                      OrderData.orders.indexOf(order);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          OrderDetailsScreen(
                        order: order,
                        index: realIndex,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}