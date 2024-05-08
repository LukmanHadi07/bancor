import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tambalbanonline/app/data/models/bancor_models/bancor_models.dart';
import 'package:tambalbanonline/app/routes/app_pages.dart';
import 'package:tambalbanonline/app/utils/commont/colors.dart';

class ContainerCustomListBancor extends StatelessWidget {
  final BancorApiModels bancorModels;
  const ContainerCustomListBancor({
    Key? key,
    required this.bancorModels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: Colors.grey.withOpacity(0.5), // Warna shadow
              blurRadius: 2,
              offset: const Offset(0, 5), // Posisi shadow (x, y)
            ),
          ],
        ),
        child: Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Image.network(
        bancorModels.gambarJasaBancor!,
        fit: BoxFit.cover,
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Text(
              bancorModels.nama!,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.orange
              ),
            ),
            Text('Rp.${bancorModels.harga}'),
          ],
        ),
      ),
    ),
    const Gap(50),
    Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10),
      child: Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          child: const Icon(
            Icons.arrow_circle_right,
            color: ColorsApp.orange,
          ),
        ),
      ),
    ),
  ],
)

      ),
    );
  }
}