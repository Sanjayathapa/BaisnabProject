import 'dart:developer';
import 'dart:io';
import 'package:baisnab/Admin/adminscreen/admin.dart';
import 'package:baisnab/users/craud/changepassword.dart';
import 'package:baisnab/users/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'signup_screen.dart';
import '../pradip/phone.dart';
import '../../services/firebase_auth_service.dart';

import '../screens/forgot_passwor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add form key
  var isPasswordObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleBtnClick() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Show CircularProgressIndicator while processing
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 246, 243, 243),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Logging in...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        Navigator.of(context).pop(); 

        if (userCredential.user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomeScreen(
                recipeMenu: [],
                title: '',
              ),
            ),
          );
        }
      }
    } catch (e) {
      log('Google Sign-In Error: $e');
     

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Unable to login with Google.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _handleLogin() async {
    try {
      if (_formKey.currentState!.validate()) {
        // Validate the form
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 246, 243, 243),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Logging in...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        );

        final String email = _emailController.text.trim();
        final String password = _passwordController.text.trim();

        await FirebaseAuthService().login(email, password);

        _emailController.clear();
        _passwordController.clear();

        Navigator.pop(context);

        final User? user = FirebaseAuth.instance.currentUser;

        if (user?.email?.toLowerCase() == 'admin@gmail.com') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                 AdminDashboard(), // Navigate to admin-specific page
            ),
          );
        } else if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                title: '',
                recipeMenu: [],
              ),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Authentication Error: ${e.message}');

      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Invalid Username or Password"),
            content: const Text(
              "Please check your credentials and try again or register if you are not registered.",
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 33, 33),
                ),
                child: const Text(
                  "Try Again",
                  style: TextStyle(
                    color: Color.fromARGB(255, 251, 247, 247),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 70, 239, 13),
                ),
                child: const Text(
                  "Register Now",
                  style: TextStyle(
                    color: Color.fromARGB(255, 249, 252, 246),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
              )
            ],
          );
        },
      );
    }
  }

  var isobx = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 246, 253),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
             
              key: _formKey, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               
                  Center(
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Welcome to our Baisnab sweets!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                  Center(
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Login to continue',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_rounded),
                        labelText: 'E-mail',
                        hintText: 'Your E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an Email';
                        } else if (!isEmailValid(value)) {
                          return 'Please enter a valid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: isPasswordObscured,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordObscured = !isPasswordObscured;
                            });
                          },
                        ),
                        hintText: 'Password',
                        labelText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        } else if (value.length < 6) {
                          return 'At least enter 6 characters';
                        } else if (value.length > 25) {
                          return 'Maximum character is 25';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RestPassword()));
                            },
                            child: const Text("Forgot Password?",
                                style: TextStyle(
                                  color: Color(0xff6A707C),
                                  fontSize: 15,
                                )),
                          ),
                        ),
                      ),
                      // Text("Or",
                      //     style: TextStyle(
                      //       color: Color.fromARGB(255, 7, 9, 12),
                      //       fontSize: 15,
                      //     )),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: InkWell(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) =>
                      //                   ChangePasswordScreen(),
                      //             ));
                      //       },
                      //       child: const Text("Change Password",
                      //           style: TextStyle(
                      //             color: Color.fromARGB(255, 88, 143, 251),
                      //             fontSize: 15,
                      //           )),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Padding(
                     padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xEB4BDBF8),
                            Color.fromARGB(255, 225, 102, 249)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                       
                        style: ElevatedButton.styleFrom(
                          // minimumSize: Size(double.infinity, 50.0),
                           backgroundColor: Colors.transparent,
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                     ),),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.height * 0.15,
                          color: Colors.grey,
                        ),
                        const Text("Or Login with"),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.height * 0.18,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: InkWell(
                            onTap: () async {
                              _handleGoogleBtnClick();
                              AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 246, 243, 243),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 16),
                                    Text(
                                      'Logging in...',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/google_logo.png',
                                  height: 30.0,
                                  width: 30.0,
                                ),
                                const SizedBox(width: 10.0),
                                const Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyPhone()));
                                    //SignWithPhone
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/phone.png',
                                        height: 30.0,
                                        width: 30.0,
                                      ),
                                      const SizedBox(width: 10.0),
                                      const Text(
                                        'Sign In With Phone',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(48, 8, 8, 8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Don't have an account?",
                            style: TextStyle(
                              color: Color(0xff1E232C),
                              fontSize: 15,
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text("  Register Now",
                              style: TextStyle(
                                color: Color(0xff35C2C1),
                                fontSize: 15,
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    ));
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
