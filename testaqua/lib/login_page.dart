import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signup_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String id = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _emailError = '';
  String _passwordError = '';
  String _loginError = '';

  final _auth = FirebaseAuth.instance;

  void _login(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    // Validate email and password fields
    bool isEmailValid = _validateEmail(email);
    bool isPasswordValid = _validatePassword(password);

    if (isEmailValid && isPasswordValid) {
      // Save the email and password to Hive
      // Navigate to the HomePage
      Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.white,
          size: 200,
        ),
      );
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (user != null) {
          Navigator.pushNamed(context, HomePage.id);
        }
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
          if (e is FirebaseAuthException) {
            _loginError = e.message.toString();
          }
        });
        print(e);
      }
    }
  }

  bool _validateEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    bool isValid = emailRegex.hasMatch(email);

    if (email.isEmpty) {
      setState(() {
        _emailError = 'Email field cannot be empty';
      });
      isValid = false;
    } else if (!isValid) {
      setState(() {
        _emailError = 'Enter a Valid Email';
      });
    } else {
      setState(() {
        _emailError = '';
      });
    }
    return isValid;
  }

  bool _validatePassword(String password) {
    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Password field cannot be empty';
      });
      return false;
    } else {
      setState(() {
        _passwordError = '';
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                      "Login Page",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
                    ),
                    const SizedBox(height: 30),
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
                      controller: _emailController,
                      placeholder: "Enter Your Email Id",
                      onChanged: (value) {
                        _validateEmail(value);
                      },
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      _emailError,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 30),
                    CupertinoTextField(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      suffix: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.remove_red_eye),
                      ),
                      prefix: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.password),
                      ),
                      textAlign: TextAlign.center,
                      controller: _passwordController,
                      placeholder: "Enter Your Password",
                      obscureText: true,
                      onChanged: (value) {
                        _validatePassword(value);
                      },
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      _passwordError,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      _loginError,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, SignupScreen.id);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.blue),
                        )),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          _login(context);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
