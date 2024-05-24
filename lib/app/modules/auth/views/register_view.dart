import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tambalbanonline/app/modules/auth/controllers/auth_controller.dart';


class RegisterScreen extends StatefulWidget {  
   
   
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 final AuthController authController = Get.put(AuthController());

 final TextEditingController _nameController = TextEditingController();


 final TextEditingController _emailController = TextEditingController();

 final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool ibObscure = true;

  String get name => _nameController.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 25),
              child: Image.asset('assets/LOGO.png',  height: 200,),
            ),
             const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Register' ,
                              textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFF701D)
                              
                            ),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus di isi';
                  }
                 if (_containsDigits(value)) {
                    return "Nama harus berisi huruf, tidak boleh angka";
                 }
                 return null;
                },
               controller: _nameController,
               keyboardType: TextInputType.name,
               decoration:const  InputDecoration(
            labelText: 'Name',
            hintText: 'Enter your name',
            border: OutlineInputBorder(
               borderSide: BorderSide(color: Color(0xff2596BE), width: 2.0),
            ),
            ),
               ),
               ),
               Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
               controller: _emailController,
               keyboardType: TextInputType.emailAddress,
               validator: (value) {
                 if (value == null || value.isEmpty) {
                  return 'Email harus di isi';
                 } 
                 if (!_isValidEmail(value)) {
                   return 'Invalid email format => admin@gmail.com';
                 }
                 return null;
               },
               decoration:const  InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            border: OutlineInputBorder(
               borderSide: BorderSide(color: Color(0xff2596BE), width: 2.0),
            ),
            ),
               ),
              ),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextFormField(
              obscureText: ibObscure,
               controller: _passwordController,
               keyboardType: TextInputType.visiblePassword,
               decoration:  InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your email',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () {
                 setState(() {
                              ibObscure = !ibObscure; // Toggle nilai isObscure
                            });
              },
              // ignore: dead_code
              icon: Icon(ibObscure ? Icons.visibility_off : Icons.visibility),
              
              ),
               ),
                validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password harus di isi';
              } else if(value.length < 4) {
                return 'Password harus berisi 4 karakter';
              } else if(value.length > 10) {
                return 'Password maksimal 10 karakter';
              } else {
                return null;
              }
                    },
               
              ),
            ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
               child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10)
                ),
                child: Obx(() {
                return authController.isLoading.value ? const Center(
                  child: CircularProgressIndicator(),
                ) : TextButton(onPressed: (){
              if(_formKey.currentState!.validate() ) {
                authController.register(email, password);
              }
          
                }, child: const Text('Register', style: TextStyle(
          fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),));
                })
               ),
             ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const  Text('Have Account ? ' ,
                     style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                       color:
                      Color(0xffFF701D),
                     ),),
            InkWell(
              onTap: (){
                Get.offNamed('/login');
              },
              child: const Text('Login ' ,
                       style: TextStyle(
                        fontWeight: FontWeight.bold,
                         color: Color(0xff2596BE)
                       ),),
            )
              ],
            ),
             
            ],
          ),
        ),
      )
    );
  }

  bool _containsDigits(String value) {
      return value.contains(RegExp(r'[0-9]'));
  }
 
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // You can adjust this regex as per your requirements
    return emailRegex.hasMatch(email);
  }
}

