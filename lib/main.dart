// import 'package:evocapp/screens/home_page.dart';
import 'package:evocapp/screens/startup.dart';
// import 'package:evocapp/screens/startup.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('notesBox');
  await Hive.openBox('UsersBox');

  const String email = '';
  runApp(const MyApp(
    email: email,
  ));
}

class MyApp extends StatelessWidget {
  final String email;
  const MyApp({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStartup(email: email),
    );
  }
}
