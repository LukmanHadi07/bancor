import 'dart:convert';

import 'package:get/get.dart';
import 'package:tambalbanonline/app/data/models/bancor_models/bancor_models.dart';
import 'package:http/http.dart' as http;

class ListTambalBanControllers extends GetxController {
  final bancorApi = <BancorApiModels>[].obs;
  final RxBool loading = true.obs;
  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllDataBancor();
  }

  Future<void> getAllDataBancor() async {
    loading.value = true;

    try {
      final url = Uri.parse('http://172.20.0.1:8000/api/bancorapi');
      final response = await http.get(url);
       // Print the response from the API
      print('API Response: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> bancorData = jsonDecode(response.body);
        final List<BancorApiModels> bancorDataParsed = bancorData
            .map((bancorData) => BancorApiModels.fromJson(bancorData))
            .toList();
        bancorApi.assignAll(bancorDataParsed);
      } else {
        throw Exception('Failed to load data'); // Throw an exception for non-200 status codes
      }
    } catch (e) {
      hasError(true);
    } finally {
      loading.value = false;
    }
  }
}
