import 'package:evocapp/components/signupbutton.dart';
import 'package:flutter/material.dart';
import 'package:evocapp/components/squaretile.dart';
import 'package:evocapp/components/textfield.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:evocapp/screens/loginpage.dart';

class MySignUpPage extends StatefulWidget {
  final String email;
  const MySignUpPage({super.key, required this.email});

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late Box _box;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    _box = await Hive.openBox('UsersBox');
  }

  void _signUp() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final existingPassword = _box.get(email);

    if (existingPassword != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('User already exists'),
      ));
    } else if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter both email and password'),
      ));
    } else {
      _box.put(email, password);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sign Up Successful!'),
      ));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyLoginPage(
            email: widget.email,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                "Create your account",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Enter your details to create an account.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 100),
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obsecureText: false,
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obsecureText: true,
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 20),
              MySignup(onPressed: _signUp),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MyLoginPage(
                            email: widget.email,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign In',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                'or',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
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
