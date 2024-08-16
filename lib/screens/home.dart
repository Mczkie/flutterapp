// import 'dart:ffi';

import 'package:evocapp/components/calendar.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  final String email;

  const MyHome({super.key, required this.email});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: 300, // Adjust width if needed
                  height: 400, // Adjust height if needed
                  child: const MyCalendar(),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
