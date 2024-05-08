import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tambalbanonline/app/data/models/bancor_models/bancor_models.dart';
import 'package:tambalbanonline/app/modules/detail_tambalban/controllers/detail_tambalban_controllers.dart';

import 'package:tambalbanonline/app/utils/commont/colors.dart';

class DetailTambalBan extends StatelessWidget {
  final int id;
  const DetailTambalBan({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: button(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          imageContainer(),
          titleText(),
          locationTitle(),
        ],
      ),
    );
  }

  Widget imageContainer() {
    final DetailTambalBanController detailTambalBanController = Get.find();
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(100))),
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(100)),
            child: GetBuilder<DetailTambalBanController>(
                init: detailTambalBanController,
                builder: ((detailTambalBanController) {
                  final List<BancorApiModels> bancorApi =
                      detailTambalBanController.bancorApi;
                  final int index =
                      bancorApi.indexWhere((bancor) => bancor.id == id);

                  final int currentIndex = index >= 0 ? index : 0;
                  return Image.network(
                    detailTambalBanController
                        .bancorApi[currentIndex].gambarJasaBancor!,
                    fit: BoxFit.cover,
                  );
                })),
          ),
        ),
        Positioned(
            top: 25,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: Colors.white,
                    size: 40,
                  )),
            )),
      ],
    );
  }

  Widget titleText() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: GetBuilder<DetailTambalBanController>(
            builder: ((detailTambalBanController) {
          final List<BancorApiModels> bancorApi =
              detailTambalBanController.bancorApi;
          final int index = bancorApi.indexWhere((bancor) => bancor.id == id);

          final int currentIndex = index >= 0 ? index : 0;
          return Center(
            // ignore: prefer_const_constructors
            child: Text(
              detailTambalBanController.bancorApi[currentIndex].nama!,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.orange),
            ),
          );
        })));
  }

  Widget locationTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: GetBuilder<DetailTambalBanController>(
          builder: ((detailTambalBanController) {
        final List<BancorApiModels> bancorApi =
            detailTambalBanController.bancorApi;
        final int index = bancorApi.indexWhere((bancor) => bancor.id == id);

        final int currentIndex = index >= 0 ? index : 0;
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  detailTambalBanController.bancorApi[currentIndex].alamat!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      })),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: ColorsApp.orange,
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'TELURUSI LOKASI TAMBAL BAN',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: ColorsApp.ligthBlue,
                  borderRadius: BorderRadius.circular(10)),
              child: GetBuilder<DetailTambalBanController>(
                  builder: ((detailTambalBanController) {
                final List<BancorApiModels> bancorApi =
                    detailTambalBanController.bancorApi;
                final int index =
                    bancorApi.indexWhere((bancor) => bancor.id == id);

                final int currentIndex = index >= 0 ? index : 0;
                return TextButton(
                    onPressed: () {
                      detailTambalBanController
                          .toWhatsApp(bancorApi[currentIndex].noHp!);
                    },
                    child: const Text(
                      'PANGGIL JASA VIA WHATSAPP',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ));
              })),
            ),
          ],
        ),
      ),
    );
  }
}
