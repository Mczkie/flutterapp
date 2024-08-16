import 'package:evocapp/screens/scanner.dart';
import 'package:flutter/material.dart';

class MyNewHome extends StatefulWidget {
  const MyNewHome({super.key});

  @override
  State<MyNewHome> createState() => _MyNewHomeState();
}

class _MyNewHomeState extends State<MyNewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyScanner(),
                ),
              );
            },
            child: const Text('Scanner'),
          ),
        ),
      ),
    );
  }
}
