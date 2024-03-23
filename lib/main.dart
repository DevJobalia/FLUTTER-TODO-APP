import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import 'package:untitled/auth/main_page.dart';
import "package:untitled/firebase_options.dart";
import 'package:untitled/screen/add_note.dart';
import 'package:untitled/screen/home.dart';
import 'package:untitled/widgets/task-widgets.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'untitled',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main_Page(),
    );
  }
}
