import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tambalbanonline/app/modules/profile/views/profile_view.dart';
import 'package:tambalbanonline/app/routes/app_pages.dart';
import 'package:tambalbanonline/app/utils/commont/colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var userLocation = const LatLng(0, 0);
  final HomeController homeController = Get.put(HomeController());
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition? _initialCameraPosition;


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
        });
      } else {
         throw Exception('Location permission not granted');
      }
    } catch (e) {
     print(e);
    }
  }

  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Obx(() => homeController.isLoading.value
              ? _buildShimmerContainer()
              : _buildMapContainer()),
          InkWell(onTap: () {}, child: _containerDaftarTambanBan())
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileView()));
        },
        backgroundColor: ColorsApp.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: const Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildShimmerContainer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 500,
        color: Colors.white,
      ),
    );
  }

  Widget _buildMapContainer() {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: _initialCameraPosition != null  ? GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _initialCameraPosition!,
         markers: {
        Marker(
          markerId: const MarkerId('userLocation'),
          position: userLocation,
          infoWindow: const InfoWindow(
            title: 'Lokasi Anda', 
            snippet: 'Ini adalah lokasi Anda',
          ),
        ),
      },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ) :  null
    );
  }
}

Widget _containerDaftarTambanBan() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Container(
      width: 300,
      height: 50,
      decoration: const BoxDecoration(
          color: ColorsApp.orange,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10), topRight: Radius.circular(10))),
      child: Center(
          child: InkWell(
        onTap: () {
          Get.toNamed(Routes.listTambalBan);
        },
        child: const Text(
          'Daftar Lokasi Tambal Ban',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      )),
    ),
  );
}
