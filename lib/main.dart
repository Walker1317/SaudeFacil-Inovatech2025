import 'package:flutter/material.dart';
import 'package:saude_facil_inovatech/views/home/home_view.dart';
import 'package:saude_facil_inovatech/widgets/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saúde Fácil',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: HomeView(),
    );
  }
}