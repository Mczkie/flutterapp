// ignore_for_file: avoid_print

import 'package:evocapp/screens/home_page.dart';
import 'package:evocapp/screens/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:evocapp/components/logtext.dart';
import 'package:evocapp/components/squaretile.dart';
import 'package:evocapp/components/textfield.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyLoginPage extends StatefulWidget {
  final String email;

  const MyLoginPage({super.key, required this.email});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late Box _box;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _box = Hive.box('UsersBox');
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    final email = emailController.text.trim();
    final password = passwordController.text;

    final storedPassword = _box.get(email);

    print('Attempting to log in with email: $email');
    print('Stored password: $storedPassword');
    print('Entered password: $password');

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    if (storedPassword == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Users not found'),
      ));
    } else if (storedPassword != password) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password is Incorrect!')));
    } else {
      var box = Hive.box('usersBox');
      box.put('isLoggedIn', true);
      box.put('loggedInUser', email);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            email: widget.email,
          ),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    // Login into your account
                    const SizedBox(height: 50),
                    const Text(
                      "Login into your account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Welcome back! Please enter your details.
                    const Text(
                      'Welcome! Please enter your details.',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(
                      height: 100,
                    ),
                    // Email placeholder
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obsecureText: false,
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    // Password placeholder
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obsecureText: true,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // forget password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => MySignUpPage(
                                    email: widget.email,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Forget Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // login button
                    const SizedBox(
                      height: 20,
                    ),
                    MyLogText(onPressed: _login),

                    // Do you have an Account? Sign In
                    const SizedBox(
                      height: 30,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Do you have an account?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => MySignUpPage(
                                  email: widget.email,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                wordSpacing: -1.5),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'or',
                      style: TextStyle(fontSize: 20),
                    ),

                    // Sign google and facebook
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                          imagePath: 'images/googles.png',
                        ),
                        SquareTile(
                          imagePath: 'images/facebooks.png',
                        )
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
