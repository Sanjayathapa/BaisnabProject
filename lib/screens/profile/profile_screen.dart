import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProfileScreen(),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? _user;
  late String _userEmail = '';
  late String _userImageUrl = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final userEmail = user.email; // Get the authenticated user's email
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          final userData = userSnapshot.docs.first.data() as Map<String, dynamic>;

          setState(() {
            _user = user;
            _userEmail = userData['email'] ?? '';
            _userImageUrl = userData['profileImageUrl'] ?? '';
          });
        } else {
          print('User document with email $userEmail not found.');
        }
      } catch (e) {
        // Handle any errors that occur during data retrieval.
        print('Error fetching user data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: _userImageUrl.isNotEmpty
                  ? NetworkImage(_userImageUrl)
                  : null,
            ),
            SizedBox(height: 20),
            Text('Email: $_userEmail'),
          ],
        ),
      ),
    );
  }
}
