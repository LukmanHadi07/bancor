import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tambalbanonline/app/utils/commont/colors.dart';

class DetailTambalBan extends StatelessWidget {
  const DetailTambalBan({super.key});

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
    return Stack(
      children: [
        Container(
        width: double.infinity,
        height: 400,
        decoration: const BoxDecoration(
             color: Colors.grey,
          borderRadius: BorderRadius.only(
            bottomLeft:Radius.circular(100)
          )
        ),
      ),
         Positioned(
          top: 25,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: InkWell(
              onTap: (){
                Get.back();
              },
              child: const Icon(Icons.keyboard_arrow_left_rounded, color: Colors.white, size: 40,)),
          )),
      ],
      
    );
  }

  Widget titleText() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Center(child: Text('Tambal Ban Jaya Siman', style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold
      ),)),
    );
  }

  Widget locationTitle() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Jl. Protokol No.45, RT.01/RW.01, Kembangan, Ngayung, Kec. Maduran, Kabupaten Lamongan, Jawa Timur 62261',
              textAlign: TextAlign.center, // Teks di tengah secara horizontal
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
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
              borderRadius: BorderRadius.circular(10)
             ),
             child: TextButton(onPressed: (){}, child: const Text(
               'TELURUSI LOKASI TAMBAL BAN', style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white
               ),
             )),
          ),
          Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 25
        ),
         width: double.infinity,
         height: 50,
         decoration: BoxDecoration(
          color: ColorsApp.ligthBlue,
          borderRadius: BorderRadius.circular(10)
         ),
         child: TextButton(onPressed: (){}, child: const Text(
           'TELURUSI LOKASI TAMBAL BAN', style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white
           ),
         )),
      ),
        ],
      ),
    ),
  );
}


}