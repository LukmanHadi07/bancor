import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tambalbanonline/app/modules/profile/views/profile_view.dart';
import 'package:tambalbanonline/app/routes/app_pages.dart';
import 'package:tambalbanonline/app/utils/commont/colors.dart';
import '../controllers/home_controller.dart';

class HomeView  extends StatelessWidget {
 final HomeController homeController = Get.put(HomeController());



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Obx(() => homeController.isLoading.value
              ? _buildShimmerContainer()
              : _buildMapContainer()),
          InkWell(
            onTap: (){},
            child: _containerDaftarTambanBan())
        ]),
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileView()));
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
    child: Obx(
      () => GoogleMap(
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            homeController.userLocation.value.latitude,
            homeController.userLocation.value.longitude,
          ),
          zoom: 9.2,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('af8a091de5db5584'),
            position: LatLng(
              homeController.userLocation.value.latitude,
              homeController.userLocation.value.longitude,
            ),
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
