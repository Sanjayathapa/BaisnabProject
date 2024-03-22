import 'dart:io';
import 'dart:developer';
import 'package:baisnab/users/craud/phone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../craud/google.dart';
// import 'package:google_fonts/google_fonts.dart';
import '../pradip/phone.dart';
import '../screens/home_screen.dart';
import '../../services/firebase_auth_service.dart';
import '../../widgets/customized_button.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../helper/helper.dart';

import 'package:theme_manager/theme_manager.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController =  TextEditingController(); 
    
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
  // Add this variable to track loading state

  void _handleGoogleBtnClick() async {
    // Show a loading indicator
    setState(() {
      isLoading = true;
    });

    try {
      final UserCredential? userCredential = await _signInWithGoogle();

      // Hide the loading indicator
      setState(() {
        isLoading = false;
      });

      if (userCredential != null) {
        log('\nUser: ${userCredential.user}');
        log('\nUserAdditionalInfo: ${userCredential.additionalUserInfo}');
      } else {
        // Show an error dialog if Google sign-in fails
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
    } catch (e) {
      // Hide the loading indicator
      setState(() {
        isLoading = false;
      });

      // Handle exceptions and show an error dialog
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
      log('\n_handleGoogleBtnClick: $e');
      Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
    }
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      return null;
    }
  }

  var isobx = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFE5F9F6),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            Form(
              key: _formKey, // Attach the form key to the form
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'username',
                        hintText: ' your name',
                      ),
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (value.length < 6) {
                          return 'Too short';
                        }
                        if (RegExp(r'\d').hasMatch(value)) {
                          return 'Username should not contain numbers';
                        }
                        return null;
                      },
                    ),
                  ),
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
                    child: TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        labelText: 'Address',
                        hintText: 'Your address',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        labelText: 'Phone Number',
                        hintText: 'Your phone number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // minimumSize: Size(double.infinity, 50.0),
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: isLoading
                            ? null
                            : () async {
                                FirebaseAuth _auth = FirebaseAuth.instance;
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await FirebaseAuthService().signup(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                       _usernameController.text.trim(),
                                      _addressController.text.trim(),
                                      _phoneNumberController.text.trim(),
                                    );

                                    // Call postDetailsToFirestore and store the result directly
                                    bool added = await postDetailsToFirestore(
                                      _emailController.text.trim(),
                                      _usernameController.text.trim(),
                                      _addressController.text.trim(),
                                      _phoneNumberController.text.trim(),
                                      _auth,
                                    );

                                   

                                    // Clear the text fields
                                    _usernameController.clear();
                                    _emailController.clear();
                                    _passwordController.clear();
                                    _addressController.clear();
                                    _phoneNumberController.clear();

                                    // Navigate to login screen
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  } on FirebaseException catch (e) {
                                    debugPrint(e.message);
                                  }
                                }
                              },
                        child: Text('Register',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: InkWell(
                                  onTap: () async {
                                    _handleGoogleBtnClick();
                                    AlertDialog(
                                      backgroundColor: const Color.fromARGB(
                                          255, 246, 243, 243),
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
          ])),
    ));
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}


Future<Position> _getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permission still denied
      return Future.error('Location permissions are denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // Get user's current location
  return await Geolocator.getCurrentPosition();
}
Future<bool> postDetailsToFirestore(
  String email, String username, String address, String phoneNumber, FirebaseAuth auth) async {
  try {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = auth.currentUser;

    if (user != null) {
      CollectionReference usersCollection =
          firebaseFirestore.collection('userslist');

      var userDoc = await usersCollection.doc(user.uid).get();
      if (userDoc.exists) {
       
        return false;
      } else {
        // Get user's current location
        Position position = await _getCurrentLocation();

        // Extract latitude and longitude
        double latitude = position.latitude;
        double longitude = position.longitude;

        // User doesn't exist, proceed with adding details
        await usersCollection.doc(user.uid).set({
          'email': email,
          'username': username,
          'address': address,
          'phoneNumber': phoneNumber,
          'latitude': latitude, // Store latitude
          'longitude': longitude, // Store longitude
        });
        // Show success dialog
        //  showSuccessDialog;
        return true;
      }
    }
  } catch (e) {
    print('Error posting details to Firestore: $e');
  }
  return false;
}