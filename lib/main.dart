import 'package:flutter/material.dart';
import 'package:google_keep_notes_clone/database/sqlite_database/firebase_database/google_sign_in.dart';
import 'package:google_keep_notes_clone/screens/home_screen.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new ChangeNotifierProvider(
      create: (context) => new GoogleSignInProvider(), child: const MyApp()));
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
