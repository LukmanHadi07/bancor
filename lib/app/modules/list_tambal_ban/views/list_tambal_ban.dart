import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tambalbanonline/app/modules/detail_tambalban/controllers/detail_tambalban_controllers.dart';
import 'package:tambalbanonline/app/modules/list_tambal_ban/controllers/list_tambal_ban_controllers.dart';
import 'package:tambalbanonline/app/modules/list_tambal_ban/widgets/custom_container_list_bancor.dart';
import 'package:tambalbanonline/app/utils/commont/colors.dart';

class ListTambalBan extends StatelessWidget {
  final ListTambalBanControllers bancor = Get.put(ListTambalBanControllers());
  final DetailTambalBanController detailTambalBanController = Get.put(DetailTambalBanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.orange,
        title: const Text(
          'DAFTAR BANCOR',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Obx(() {
            if (bancor.loading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (bancor.hasError.value) {
              return Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/error.png',
                      width: 500,
                      height: 500,
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: bancor.bancorApi.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        final DetailTambalBanController
                            detailTambalBanController = Get.find();
                        final id = bancor.bancorApi[index].id;
                        await detailTambalBanController
                            .detailTambalBanById(id.toString());
                        Get.toNamed('/detail-tambalban/$id');
                      },
                      child: ContainerCustomListBancor(
                        bancorModels: bancor.bancorApi[index],
                      ),
                    );
                  });
            }
          })),
    );
  }
}
