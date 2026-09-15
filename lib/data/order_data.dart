import 'dart:convert';

class OrderModel {
  final String service;
  final String status;
  final String phone;
  final String address;
  final String description;
  final String? imagePath;

  final double latitude;
  final double longitude;

  OrderModel({
    required this.service,
    required this.status,
    required this.phone,
    required this.address,
    required this.description,
    this.imagePath,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'service': service,
      'status': status,
      'phone': phone,
      'address': address,
      'description': description,
      'imagePath': imagePath,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory OrderModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return OrderModel(
      service: json['service'],
      status: json['status'],
      phone: json['phone'],
      address: json['address'],
      description: json['description'],
      imagePath: json['imagePath'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class OrderData {
  static List<OrderModel> orders = [];
}