import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: StreamBuilder<List<User>>(
        stream: FirebaseAuth.instance
            .authStateChanges()
            .asyncMap((user) async {
              if (user != null) {
                final querySnapshot = await FirebaseFirestore.instance
                    .collection('users')
                    .get();
                final users = querySnapshot.docs.map((doc) => User.fromMap(doc.data())).toList();
                return users;
              }
              return [];
            }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          var users = snapshot.data;

          if (users != null && users.isNotEmpty) {
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserListItem(user: users[index]);
              },
            );
          } else {
            return Text('No users logged in');
          }
        },
      ),
    );
  }
}

class UserListItem extends StatelessWidget {
  final User user;

  UserListItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('User ID: ${user.uid}'),
      subtitle: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          var userData = snapshot.data?.data();

          return Text('Email: ${user.email}\n'
              'Display Name: ${user.displayName ?? 'N/A'}\n'
              'Photo URL: ${user.photoURL ?? 'N/A'}\n'
              );
        },
      ),
    );
  }
}

class User {
  final String uid;
  final String email;
  final String displayName;
  final String? photoURL;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoURL,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoURL: map['photoURL'],
    );
  }
}

