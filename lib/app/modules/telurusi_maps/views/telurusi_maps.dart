import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class TelurusiMaps extends StatefulWidget {
   final int id;
  const TelurusiMaps({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TelurusiMaps> createState() => _TelurusiMapsState();
}

class _TelurusiMapsState extends State<TelurusiMaps> {
  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};
  Set<Polyline> _polyline = {};
  LatLng? destination;
  LatLng userLocation = const LatLng(0, 0);
  CameraPosition? _initialCameraPosition;
  double distanceInKm = 0.0;
  BitmapDescriptor? myIcon;

  @override
  void initState() {
    _getUserLocation();
    _getDestinationLocationFromApi(widget.id.toString());
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: const Size(5, 5)), 'assets/bengkel.png')
        .then((onValue) {
      myIcon = onValue;
    });
    super.initState();
  }

  Future<void> _getDestinationLocationFromApi(String id) async {
    try {
      final url = Uri.parse('https://bancor.my.id/api/bancorapi/$id');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> bancorData = jsonDecode(response.body);
        double latitude = bancorData[0]['latitude'];
        double longitude = bancorData[0]['longitude'];
        LatLng destination = LatLng(latitude, longitude);
        String bengkelName = bancorData[0]['nama'];
        String alamat = bancorData[0]['alamat'];

        double distance = _calculateDistance(userLocation, destination);
        print('Jarak antara lokasi pengguna dan tujuan: $distance meter');

        // Konversi jarak dari meter ke kilometer
        double distanceInKm = distance / 1000;

        setState(() {
          this.destination = destination;
          this.distanceInKm = distanceInKm;
          _markers = _markers.union({
            Marker(
  markerId: MarkerId(id),
  position: destination,
  infoWindow: InfoWindow(
    title: bengkelName,
    snippet: alamat,
  ),
  icon: myIcon!
),

          });
          _updatePolyline();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getUserLocation() async {
    try {
      final permissionStatus = await Permission.location.request();
      if (permissionStatus == PermissionStatus.granted) {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          userLocation = LatLng(position.latitude, position.longitude);
          _initialCameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15.0,
          );
          _markers = _markers.union({
            Marker(
              markerId: const MarkerId('userLocation'),
              position: userLocation,
              infoWindow: const InfoWindow(
                title: 'Lokasi Saya',
              ),
              icon: BitmapDescriptor.defaultMarker,
            ),
          });
          _updatePolyline();
        });
      } else {
        throw Exception('Location permission not granted');
      }
    } catch (e) {
      print(e);
    }
  }

  double _calculateDistance(LatLng from, LatLng to) {
    return Geolocator.distanceBetween(
        from.latitude, from.longitude, to.latitude, to.longitude);
  }

  void _updatePolyline() {
    if (userLocation != const LatLng(0, 0) && destination != null) {
      _polyline = {
        Polyline(
          polylineId: const PolylineId('1'),
          color: Colors.red,
          width: 2,
          points: [userLocation, destination!],
        ),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telurusi Tambal Ban'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _initialCameraPosition != null
                ? SizedBox(
                    child: SafeArea(
                      child: GoogleMap(
                        initialCameraPosition: _initialCameraPosition!,
                        mapType: MapType.normal,
                        markers: _markers,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        compassEnabled: true,
                        polylines: _polyline,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Jarak antara lokasi anda dan tambal ban sekitar ${distanceInKm.toStringAsFixed(2)} kilometer',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}