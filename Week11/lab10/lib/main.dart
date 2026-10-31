import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

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


// In MyApp, change home: to DeviceScreen()
class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});
  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  final _picker = ImagePicker();
  String? _photoPath;
  String _locationText = 'No location yet.';

  @override
  Future<void> _getPhoto(ImageSource source) async {
    final XFile? photo = await _picker.pickImage(source: source);
    if (photo == null) return;
    setState(() {
      _photoPath = photo.path;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Spot')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _photoPath == null
                ? const Icon(Icons.image, size: 120)
                : Image.file(File(_photoPath!), height: 250),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _getPhoto(ImageSource.camera),
                  child: const Text('Camera'),
                ),
                ElevatedButton(
                  onPressed: () => _getPhoto(ImageSource.gallery),
                  child: const Text('Gallery'),
                ),
              ],
            ),
            Text(_locationText),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Get my location'),
            ),
          ],
        ),
      ),
    );
  }
}
