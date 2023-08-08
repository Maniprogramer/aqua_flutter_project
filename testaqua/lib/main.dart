import 'package:flutter/material.dart';
import 'package:testaqua/home_page.dart';
import 'package:testaqua/login_page.dart';
import 'package:testaqua/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Start());
}

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        HomePage.id: (context) => HomePage(),
        SignupScreen.id: (context) => const SignupScreen(),
      },
    );
  }
}
