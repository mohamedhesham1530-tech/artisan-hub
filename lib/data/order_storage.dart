import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'order_data.dart';

class OrderStorage {
  static Future<void> saveOrders() async {
    final prefs =
        await SharedPreferences.getInstance();

    List<String> orders =
        OrderData.orders
            .map(
              (e) =>
                  jsonEncode(e.toJson()),
            )
            .toList();

    await prefs.setStringList(
      'orders',
      orders,
    );
  }

  static Future<void> loadOrders() async {
    final prefs =
        await SharedPreferences.getInstance();

    final orders =
        prefs.getStringList('orders') ??
            [];

    OrderData.orders =
        orders
            .map(
              (e) => OrderModel.fromJson(
                jsonDecode(e),
              ),
            )
            .toList();
  }
}