import 'package:get/get.dart';
import 'package:tambalbanonline/app/modules/detail_tambalban/controllers/detail_tambalban_controllers.dart';

class DetailTambalBanBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<DetailTambalBanController>(() => DetailTambalBanController());
  }
}