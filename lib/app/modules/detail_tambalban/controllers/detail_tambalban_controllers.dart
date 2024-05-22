import 'dart:convert';

import 'package:get/get.dart';
import 'package:tambalbanonline/app/data/models/bancor_models/bancor_models.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DetailTambalBanController extends GetxController {
  final activeCategory = ''.obs;
  final bancorApi = <BancorApiModels>[].obs;
  final RxBool loading = true.obs;
  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> detailTambalBanById(String id) async {
    try {
      // ignore: unrelated_type_equality_checks
      if (activeCategory != id) {
        activeCategory.value = id;
        loading.value = true;
        final url = Uri.parse('https://bancor.my.id/api/bancorapi/$id');
        final response = await http.get(url);
        // Print the response from the API
        print('API Response: ${response.body}');

        if (response.statusCode == 200) {
          final List<dynamic> bancorData = jsonDecode(response.body);
          final List<BancorApiModels> bancorDataParsed = bancorData
              .map((bancorData) => BancorApiModels.fromJson(bancorData))
              .toList();
          bancorApi.assignAll(bancorDataParsed);
        }
      }
    } catch (e) {
      hasError(true);
    } finally {
      loading.value = false;
    }
  }

  Future<void> toWhatsApp(String noHp) async {
    final  whatsAppUrl = 'https://wa.me/?phone=$noHp';
    try {
      await launchUrl(Uri.parse(whatsAppUrl));
    } catch (e) {
      print(e);
    }
  }

  
}
