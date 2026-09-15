import 'dart:io';
import '../../data/notification_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../data/order_data.dart';
import '../../data/order_storage.dart';
import '../map/select_location_screen.dart';

class CreateOrderScreen extends StatefulWidget {
  final String serviceName;

  const CreateOrderScreen({super.key, required this.serviceName});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final phoneController = TextEditingController();

  final addressController = TextEditingController();

  final descriptionController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  LatLng? selectedLocation;

  File? selectedImage;

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Create Order",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xff2563EB),
                    child: Icon(Icons.home_repair_service, color: Colors.white),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      widget.serviceName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Phone Number",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,

              decoration: InputDecoration(
                hintText: "Enter phone number",
                prefixIcon: const Icon(Icons.phone),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: addressController,
              maxLines: 2,

              decoration: InputDecoration(
                hintText: "Enter your address",
                prefixIcon: const Icon(Icons.home),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Problem Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: descriptionController,
              maxLines: 5,

              decoration: InputDecoration(
                hintText: "Describe your problem...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Upload Image",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            InkWell(
              onTap: pickImage,

              child: Container(
                height: 170,
                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(selectedImage!, fit: BoxFit.cover),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(Icons.add_a_photo, size: 40),

                          SizedBox(height: 10),

                          Text("Upload Problem Image"),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Location",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            InkWell(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SelectLocationScreen(),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedLocation = result as LatLng;
                  });
                }
              },

              child: Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        selectedLocation == null
                            ? "Select Location"
                            : "${selectedLocation!.latitude.toStringAsFixed(5)}, ${selectedLocation!.longitude.toStringAsFixed(5)}",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2563EB),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                onPressed: () async {
                  if (selectedLocation == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select location")),
                    );
                    return;
                  }

                  OrderData.orders.add(
                    OrderModel(
                      service: widget.serviceName,
                      status: "Pending",
                      phone: phoneController.text,
                      address: addressController.text,
                      description: descriptionController.text,
                      imagePath: selectedImage?.path,

                      latitude: selectedLocation!.latitude,

                      longitude: selectedLocation!.longitude,
                    ),
                  );

                  await OrderStorage.saveOrders();
                  NotificationData.notifications.insert(
                    0,
                    "${widget.serviceName} order created successfully",
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        "${widget.serviceName} order created successfully",
                      ),
                    ),
                  );

                  Navigator.pop(context);
                },

                child: const Text(
                  "Confirm Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
}
