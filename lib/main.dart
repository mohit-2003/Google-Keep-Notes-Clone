import 'package:flutter/material.dart';
import 'package:google_keep_notes_clone/screens/home_screen.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Keep Notes',
      home: const MyHomePage(),
      theme: new ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new HomeScreen();
  }
}
