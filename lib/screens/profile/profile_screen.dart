import 'package:baisnab/screens/theme.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Fetch additional user data using UID
        User? user = await _auth.userChanges().first;

        setState(() {
          _user = user;
        });

        print("User UID: ${_user!.uid}");
        print("User Email: ${_user!.email}");
      } else {
        print("User not authenticated");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final themeProvider = Provider.of<ThemeNotifier>(context);
    return Consumer<ThemeNotifier>(builder: (context, themeProvider, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getTheme(),

          // theme: ThemeData.light(), // Define your light theme here
          // darkTheme: ThemeData.dark(),
          home: SafeArea(
              child: Scaffold(
                  body: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 50,
                                width: 40,
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back_ios_sharp),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
// GoogleFonts.lato
                              child: Text(
                                " Userprofile screen",
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 50,
                                // You can add a placeholder image or load an image from your database
                                backgroundImage: AssetImage(
                                    'assets/sweet/rasdmalai2pieces.png'),
                              ),
                              SizedBox(height: 20),
                              SizedBox(height: 10),
                              Text(
                                'Email: ${_user?.email ?? "N/A"}',
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])))));
    });
  }
}
