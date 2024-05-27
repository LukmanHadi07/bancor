import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:tambalbanonline/app/data/models/bancor_models/bancor_models.dart';
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
        height: 170,
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
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            bancorModels.gambarJasaBancor!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text(
                bancorModels.nama!,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
                 
              ),
              Text('Rp.${bancorModels.harga}', style: const TextStyle(
                color: Colors.black45,
                fontSize: 12
              ),),
              const Gap(5),
              Text('Alamat : ${bancorModels.alamat}', style: const TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w700,
                fontSize: 10
              ),
              textAlign: TextAlign.justify,
              maxLines: 4,
                  overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
    ),
    
    
    const Gap(50),
    const Padding(
      padding: EdgeInsets.only(bottom: 10, right: 10),
      child: Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          child: Icon(
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