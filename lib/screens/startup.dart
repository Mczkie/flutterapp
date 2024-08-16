import 'package:evocapp/screens/home.dart';
import 'package:evocapp/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:hive/hive.dart';

class MyStartup extends StatefulWidget {
  final String email;
  const MyStartup({super.key, required this.email});

  @override
  State<MyStartup> createState() => _MyStartupState();
}

class _MyStartupState extends State<MyStartup> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    var box = Hive.box('usersBox');
    bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);
    String email = box.get('loggedInUser', defaultValue: '');

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHome(email: email),
        ),
      );
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.green,
      pages: [
        PageViewModel(
          image: Center(
            child: Lottie.asset('images/helloLottie.json', height: 280),
          ),
          title: "Hello! Welcome to Eco Vista",
          body:
              "Eco Vista Olongapo City (EVOC) is an app to improve waste segregation and promote sustainability in Olongapo City..",
          decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            pageColor: Colors.green,
          ),
        ),
        PageViewModel(
          image: Center(
            child: Lottie.asset(
              'images/whatLottie.json',
              height: 280,
            ),
          ),
          title: "What is Eco Vista?",
          body:
              "Eco Vista is a application that used to track if the waste is a bio or Non-biodegradable.",
          decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            pageColor: Colors.green,
            bodyTextStyle: TextStyle(fontSize: 19),
          ),
        ),
      ],
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyLoginPage(
              email: widget.email,
            ),
          ),
        );
      },
      showSkipButton: true,
      skip: const Icon(
        Icons.skip_next_outlined,
        color: Colors.white,
      ),
      next: const Icon(
        Icons.arrow_circle_right_sharp,
        color: Colors.white,
      ),
      done: const Text("Done",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
      dotsDecorator: DotsDecorator(
        color: Colors.white,
        size: const Size.square(5.0),
        activeSize: const Size(15.0, 5.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
