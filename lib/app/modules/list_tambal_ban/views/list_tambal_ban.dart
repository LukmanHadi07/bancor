import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tambalbanonline/app/routes/app_pages.dart';
import 'package:tambalbanonline/app/utils/commont/colors.dart';

class ListTambalBan extends StatelessWidget {
  const ListTambalBan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.orange,
        title:  const Text('DAFTAR BANCOR', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context,  _) {
            return containerCustom();
          })
      ),
    );
  }

  Widget containerCustom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Image.asset(''),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 65, top: 15),
              child: Column(
                children: [
                  Text('Tambal Ban '),
                  Text('Desa Siser '),
                  Text('Desa Siser '),
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child:  InkWell(
                  onTap: (){
                    Get.toNamed(Routes.detailTambalBan);
                  },
                  child: const Icon(Icons.arrow_circle_right, color: Colors.white,))
              ),
            ),
          ],
        ),
      ),
    );
  }
}
