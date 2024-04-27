import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
     var isLoading = true.obs;
     final locationMessage = ''.obs;
    var userLocation = const LatLng(0, 0).obs;




  @override
  void onReady() {
      shimmerEffect();
    _getUserLocation();
    super.onReady();
  }
  
   @override
  void onClose() {
    shimmerEffect();
    super.onClose();
  }

 

  void shimmerEffect() {
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false; 
    });
  }


Future<void> _getUserLocation() async {
    isLoading.value = true;
    try {
      final permissionStatus = await Permission.location.request();
      if (permissionStatus == PermissionStatus.granted) {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        userLocation.value = LatLng(position.latitude, position.longitude);
      } else {
        throw Exception('Location permission not granted');
      }
    } catch (e) {
      print('Error fetching user location: $e');
      // Handle error, display message to the user, etc.
    } finally {
      isLoading.value = false;
    }
  }
}
