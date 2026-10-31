
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DeviceScreen(),
    );
  }
}

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  final ImagePicker _picker = ImagePicker();

  String? _photoPath;
  String _locationText = 'No location yet.';

  // Pick image from camera or gallery
  Future<void> _getPhoto(ImageSource source) async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: source,
      );

      if (photo == null) return;

      setState(() {
        _photoPath = photo.path;
      });
    } catch (e) {
      debugPrint('Image error: $e');
    }
  }

  // Get current device location
  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check location permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permission permanently denied. '
        'Enable it in app settings.',
      );
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  // Display location
  Future<void> _showLocation() async {
    setState(() {
      _locationText = 'Getting location...';
    });

    try {
      final Position pos = await _getLocation();

      if (!mounted) return;

      setState(() {
        _locationText =
            'Latitude: ${pos.latitude.toStringAsFixed(4)}\n'
            'Longitude: ${pos.longitude.toStringAsFixed(4)}';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _locationText = 'Could not get location: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Spot'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display selected image
              _photoPath == null
                  ? const Icon(
                      Icons.image,
                      size: 120,
                      color: Colors.grey,
                    )
                  : Image.file(
                      File(_photoPath!),
                      height: 250,
                      fit: BoxFit.cover,
                    ),

              const SizedBox(height: 20),

              // Camera and Gallery buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _getPhoto(ImageSource.camera),
                    child: const Text('Camera'),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () => _getPhoto(ImageSource.gallery),
                    child: const Text('Gallery'),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Display location
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _locationText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              // Get location button
              ElevatedButton.icon(
                onPressed: _showLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Get my location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
