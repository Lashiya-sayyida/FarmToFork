// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'homepage.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late final String _selectedGender = '';
  bool passkey = true;
  late ProgressDialog _progressDialog;

  Future<void> login() async {
    print(_emailController.text);
    print(_selectedGender);
    _progressDialog.show();

    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passController.text.trim());
      String? userid = userCredential.user?.uid;
      if (userid != "") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      }
      _progressDialog.hide();
    } catch (e) {
      _progressDialog.hide();
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _progressDialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            constraints: const BoxConstraints.expand(),
            child: Image.asset(
              'assets/92012.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: SizedBox(
                width: 300,
                height: 400,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                             

                              ),
                              prefixIcon: Icon(Icons.email, color: Colors.white),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              prefixIcon: const Icon(Icons.lock, color: Colors.white),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    passkey = !passkey;
                                  });
                                },
                                child: Icon(
                                  passkey ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            obscureText: passkey,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passController,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                login();
                                try {
                                  final FirebaseAuth auth = FirebaseAuth.instance;
                                  final UserCredential userCredential =
                                      await auth.signInWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passController.text.trim(),
                                  );
                                  String? userid = userCredential.user?.uid;
                                  if (userid != "") {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Homepage()),
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.blue.withOpacity(0.5);
                                  } else if (states.contains(MaterialState.disabled)) {
                                    return Colors.grey;
                                  }
                                  return Colors.blue;
                                },
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: const Text(
                              'New User? Create Account',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}
