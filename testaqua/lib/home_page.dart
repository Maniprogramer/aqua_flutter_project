import 'package:flutter/material.dart';
import 'package:testaqua/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController _controller = TextEditingController();

  static String id = "home_page";
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page'), actions: [
        IconButton(
          icon: const Icon(
              Icons.logout), // Replace 'custom_icon' with the desired icon
          onPressed: () {
            _auth.signOut();
            Navigator.pushNamed(context, LoginScreen.id);
          },
        ),
      ]),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Column(
                children: [
                  Text(
                    "Temp",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "Humidity",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String text = _controller.text;
              },
              child: const Text('Go to Second Page'),
            ),
          ],
        ),
      ),
    );
  }
}
