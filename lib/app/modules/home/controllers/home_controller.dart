import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
     var isLoading = true.obs;
     final locationMessage = ''.obs;
    var userLocation = const LatLng(0, 0).obs;

  @override
  void onInit() {
    shimmerEffect();
    _getUserLocation();
    super.onInit();

  }

 
  
  // Method to simulate data loading
  void shimmerEffect() {
    // Simulating a delay to mimic data fetching process
    Future.delayed(const Duration(seconds: 3), () {
      isLoading.value = false; // Set isLoading to false when loading is complete
    });
  }


 Future<void> _getUserLocation() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        userLocation.value = LatLng(position.latitude, position.longitude);
      } catch (e) {
        print(e);
      }
    }
  }
}

