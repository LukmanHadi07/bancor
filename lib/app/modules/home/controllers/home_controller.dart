
import 'package:get/get.dart';



class HomeController extends GetxController {
     var isLoading = true.obs;
     final locationMessage = ''.obs;




  @override
  void onReady() {
      shimmerEffect();
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
}