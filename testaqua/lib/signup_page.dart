import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:testaqua/home_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static String id = "Signup_screen";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  String username = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Center(
            child: SizedBox(
              height: double.infinity,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "SignUp Page",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefix: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.person),
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      username = value;
                    },
                    placeholder: "Enter Username",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefix: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.mail),
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    placeholder: "Enter Your Email Id",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefix: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.password),
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    placeholder: "Enter Your Password",
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      error,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.deepOrange),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            final newuser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newuser != null) {
                              Navigator.pushNamed(context, HomePage.id);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                              if (e is FirebaseAuthException) {
                                print("Exception message: ${e.message}");
                                error = e.message.toString();
                              }
                            });
                            print(e);
                          }
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
