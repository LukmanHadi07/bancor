import 'package:get/get.dart';
import 'package:tambalbanonline/app/modules/list_tambal_ban/controllers/list_tambal_ban_controllers.dart';



class ListTambalBanBindis extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTambalBanControllers>(
      () => ListTambalBanControllers(),
    );
  }
}
