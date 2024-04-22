import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tambalbanonline/app/modules/auth/controllers/auth_controller.dart';
import 'package:tambalbanonline/app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final AuthController authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool ibObscure = true;

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
                  child: Image.asset(
                    'assets/LOGO.png',
                    // width: 300,
                    height: 200,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF701D)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email harus di isi';
                      }
                      if (!_isValidEmail(value)) {
                        return 'Invalid email format => admin@gmail.com';
                      }
                      return null;
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff2596BE), width: 2.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password harus di isi";
                      } else if (value.length < 4) {
                        return 'Password minimal 4 karakter';
                      } else if (value.length > 10) {
                        return 'Password maksimal 10 karakter';
                      } 
                      return null;
                    },
                    obscureText: ibObscure,
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your email',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            // ignore: dead_code
                            icon: Icon(ibObscure
                                ? Icons.visibility_off
                                : Icons.visibility))),
                  ),
                ),
                InkWell(
                  onTapCancel: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Forgot Password ?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2596BE),
                            ))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          color: const Color(0xffFF701D),
                          borderRadius: BorderRadius.circular(10)),
                      child: Obx(() {
                        return authController.isLoading.value
                            ? const Center (child: CircularProgressIndicator())
                            : TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    authController.login(email, password);
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ));
                      })),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont Have Account ? ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFF701D),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, RoutesNames.register);
                        Get.offNamed('/register');
                      },
                      child: const Text(
                        'Register ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2596BE)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  bool _isValidEmail(String email) {
    // Regular expression for email validation
    final emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // You can adjust this regex as per your requirements
    return emailRegex.hasMatch(email);
  }

  bool _isPasswordInvalid(String value) {
    return value.contains('123');
  }
}
