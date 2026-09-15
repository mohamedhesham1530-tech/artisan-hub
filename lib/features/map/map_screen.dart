import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng currentLocation = const LatLng(31.2001, 29.9187);

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enable location service")),
        );

        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied")),
        );

        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;

      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);

        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      debugPrint("Location Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Nearby Technicians",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: currentLocation,
                    initialZoom: 14,
                  ),

                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.engz_2',
                    ),

                    MarkerLayer(
                      markers: [
                        Marker(
                          point: currentLocation,
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.location_on,
                            size: 50,
                            color: Colors.red,
                          ),
                        ),

                        Marker(
                          point: LatLng(
                            currentLocation.latitude + 0.01,
                            currentLocation.longitude + 0.01,
                          ),
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.engineering,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),

                        Marker(
                          point: LatLng(
                            currentLocation.latitude - 0.01,
                            currentLocation.longitude - 0.01,
                          ),
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.engineering,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Positioned(
                  bottom: 20,
                  left: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .1),
                          blurRadius: 10,
                        ),
                      ],
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xff2563EB),
                              child: Icon(
                                Icons.person_pin_circle,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Current Location",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Location Loaded",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Lat: ${currentLocation.latitude.toStringAsFixed(5)}",
                        ),

                        Text(
                          "Lng: ${currentLocation.longitude.toStringAsFixed(5)}",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff2563EB),
        onPressed: getLocation,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}
