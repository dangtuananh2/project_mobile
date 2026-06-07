import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  final List<Map<String, String>> jobs;

  const MapPage({super.key, required this.jobs});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng _currentPosition = const LatLng(21.0285, 105.8542);
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadJobs();
  }

  /// 🔥 LẤY VỊ TRÍ HIỆN TẠI (FIX FULL)
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ✅ Check GPS
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    // ✅ Check permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      debugPrint("Location permission denied");
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    // ✅ Lấy vị trí
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng newPos = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = newPos;

      // Marker vị trí hiện tại
      _markers.add(
        Marker(
          markerId: const MarkerId("current"),
          position: newPos,
          infoWindow: const InfoWindow(title: "Bạn đang ở đây"),
        ),
      );
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(newPos, 14),
    );
  }

  /// 🔥 Convert location -> LatLng (demo VN)
  LatLng _getLatLngFromLocation(String location) {
    switch (location) {
      case "Hà Nội":
        return const LatLng(21.0285, 105.8542);
      case "Hồ Chí Minh":
        return const LatLng(10.8231, 106.6297);
      default:
        return _currentPosition;
    }
  }

  /// 🔥 Load job từ TrangChu
  void _loadJobs() {
    for (var job in widget.jobs) {
      LatLng pos = _getLatLngFromLocation(job["location"]!);

      _markers.add(
        Marker(
          markerId: MarkerId(job["title"]!),
          position: pos,
          infoWindow: InfoWindow(
            title: job["title"],
            snippet: job["company"],
          ),
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 GOOGLE MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 12,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),

          /// 🔙 NÚT BACK
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}