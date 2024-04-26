import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tambalbanonline/app/utils/commont/colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Obx(() => controller.isLoading.value
              ? _buildShimmerContainer()
              : _buildMapContainer()),
          InkWell(
            onTap: (){},
            child: _containerDaftarTambanBan())
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Get.toNamed('/profile');
        },
        backgroundColor: ColorsApp.orange, // Warna latar belakang tombol
        shape: RoundedRectangleBorder(
          // Mengatur bentuk tombol menjadi bulat
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
        color: Colors.white, // You can set any color as a placeholder
      ),
    );
  }

 Widget _buildMapContainer() {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: Obx(
        () => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              controller.userLocation.value.latitude,
              controller.userLocation.value.longitude,
            ),
            zoom: 9.2,
          ),
          markers: {
            Marker(
              markerId: MarkerId('userLocation'),
              position: LatLng(
                controller.userLocation.value.latitude,
                controller.userLocation.value.longitude,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
          },
          onMapCreated: (GoogleMapController controller) {},
        ),
      ),
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
      child: const Center(
          child: Text(
        'Daftar Lokasi Tambal Ban',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      )),
    ),
  );
}
