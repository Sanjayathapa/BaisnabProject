import 'dart:io';
import 'dart:developer';
import 'package:baisnab/craud/phone.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../craud/google.dart';
// import 'package:google_fonts/google_fonts.dart';
import '../pradip/phone.dart';
import '../screens/home_screen.dart';
import '../services/firebase_auth_service.dart';
import '../widgets/customized_button.dart';
import '../screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helper/helper.dart';
import '../screens/theme.dart/theme_manager.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _handleGoogleBtnClick() {
    //for showing progress bar
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      //for hiding progress bar
      Navigator.pop(context);
      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen(
                                        recipeMenu: [],
                                        title: '',
                                      ),));
      }
      
          showDialog(
                      context: context,
                    builder: (BuildContext context) {
                    return AlertDialog(
                    title: const Text('Login Failed'),
                    content: const Text(
                    'Unable to login with Google.'),
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
    
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
             showDialog(
                      context: context,
                    builder: (BuildContext context) {
                    return AlertDialog(
                    title: const Text('Login Failed'),
                    content: const Text(
                    'Unable to login with Google.'),
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
      // log('\n_signInWithGoogle: $e');
      // Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
      return null;
    }
  }

  bool isloading = false;
  var isobx = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE5F9F6),
        // backgroundColor: ThemeManager == ThemeMode.light
        //     ? Colors.white
        //     : Colors.black,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          // child: SizedBox(
          //   height: MediaQuery.of(context).size.height,
          //   width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_sharp),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: ThemeManager == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                            fontSize: 45,
                          ),
                          // GoogleFonts.courgette
                        ),
                      ),
                    ),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            // ignore: unrelated_type_equality_checksGoogleFonts.courgette
                            color: ThemeManager == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.person),

              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       labelText: 'username',
              //       hintText: ' your name',
              //     ),
              //     controller: _usernameController,
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter some text';
              //       }
              //       if (value.length < 6) {
              //         return 'Too short';
              //       }
              //       if (RegExp(r'\d').hasMatch(value)) {
              //         return 'Username should not contain numbers';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,

                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
                    labelText: ' E-mail',
                    hintText: ' your E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Email';
                    } else if (!isEmailValid(value)) {
                      return 'Please enter a valid Email';
                    } else {
                      return null;
                    }
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
                  obscureText: !isobx,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_open),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isobx ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isobx = !isobx;
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: CustomizedButton(
                    buttonText: "Register",
                    // buttonColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                      try {
                        await FirebaseAuthService().signup(
                            _emailController.text.trim(),
                            _passwordController.text.trim());

                        if (!mounted) return;

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      } on FirebaseException catch (e) {
                        debugPrint(e.message);
                      }

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => const LoginScreen()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.height * 0.15,
                      color: Colors.grey,
                    ),
                    const Text("Or Register with"),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.height * 0.16,
                      color: Colors.grey,
                    ),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: InkWell(
                              onTap: () async {
                                 _handleGoogleBtnClick();
                                // final UserCredential? userCredential =
                                //     await signInWithGoogle();
                                // if (userCredential != null) {
                                //   // Login successful, navigate to the home screen
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => const HomeScreen(
                                //         recipeMenu: [],
                                //         title: '',
                                //       ),
                                //     ),
                                //   );
                                // } else {
                                  // Login failed
                                  // Display an error message to the user
                                //   showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return AlertDialog(
                                //         title: const Text('Login Failed'),
                                //         content: const Text(
                                //             'Unable to login with Google.'),
                                //         actions: [
                                //           TextButton(
                                //             child: const Text('OK'),
                                //             onPressed: () {
                                //               Navigator.of(context).pop();
                                //             },
                                //           ),
                                //         ],
                                //       );
                                //     },
                                //   );
                                // }
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.grey),
                            //   borderRadius: BorderRadius.circular(8.0),
                            // ),

                            child: InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyPhone ()));
                                            // SignWithPhone 
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(38, 8, 8, 8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(
                          color: Color(0xff1E232C),
                          fontSize: 15,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()));
                      },
                      child: const Text("  Login Now",
                          style: TextStyle(
                            color: Color(0xff35C2C1),
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // )
      ),
    );
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
