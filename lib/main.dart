import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tambalbanonline/app.dart';


Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDJYwQUjeKQxuxGPi8XjOYNPf_ifooJryk", // paste your api key here
      appId: "1:986076206133:android:e71f0458d10430db1c4d7c", //paste your app id here
      messagingSenderId: "86076206133", //paste your messagingSenderId here
      projectId: "tambalban-87241", //paste your project id here
      storageBucket: "tambalban-87241.appspot.com",
    ),
  );
  runApp(const App());
}

