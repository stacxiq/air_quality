import 'package:airquality/screen_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyAB45qbhYieY8xzyVuAxzmkIZd8eWGNnGQ',
    appId: '1:214001320438:android:39d92f0cfb2e9ddd1607d7',
    messagingSenderId: '214001320438',
    projectId: 'air-quality-4b969',
    databaseURL: 'https://air-quality-4b969-default-rtdb.firebaseio.com',
    storageBucket: 'air-quality-4b969.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Air Quality',
      theme: ThemeData(),
      home: ScreenHome(),
    );
  }
}
