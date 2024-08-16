import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer

class MyMenu extends StatefulWidget {
  const MyMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyMenuState createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  final List<String> _messages = [
    'Hello World!',
    'Welcome to Flutter!',
    'Enjoy your day!',
    'Keep coding!',
    'Stay positive!',
    'tanga!',
  ];

  String _currentMessage = '';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentMessage = _getRandomMessage();
    _startMessageTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  String _getRandomMessage() {
    final randomIndex = (DateTime.now().millisecondsSinceEpoch / 2000).floor() %
        _messages.length;
    return _messages[randomIndex];
  }

  void _startMessageTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        _currentMessage = _getRandomMessage();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 130,
      decoration: const BoxDecoration(
        color: Colors.deepOrange,
      ),
      child: Center(
          child: Text(_currentMessage, style: const TextStyle(fontSize: 20))),
    );
  }
}
