import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


  class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 251, 253),
      appBar: AppBar(
        title: Text(
          'User List',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<User>>(
        stream: FirebaseAuth.instance.authStateChanges().asyncMap((user) async {
          print('User: $user');
          if (user != null) {
            final querySnapshot =
                await FirebaseFirestore.instance.collection('userslist').get();
            final users = querySnapshot.docs.map((doc) => User.fromMap(doc.data())).toList();

            // Print user data for debugging
            users.forEach((user) {
              print('User ID: ${user.uid}, Email: ${user.email}, Username: ${user.username}, ImageURL: ${user.imageURL}, Address: ${user.address}, UserID: ${user.userId}');
            });

            // Fetch images for each user
            for (var user in users) {
              user.imageURL = await fetchImageFromUserFirestore(user.uid);
            }

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
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  // DataColumn(
                  //   label: Text(
                  //     'User ID',
                  //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                   DataColumn(
                    label: Text(
                      'User Name',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Email',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                 
                  DataColumn(
                    label: Text(
                      'Address',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                 
                  DataColumn(
                    label: Text(
                      'Photo',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: users.map((user) {
                  return DataRow(
                    cells: [
                      DataCell(Container(color: Colors.yellow, child: Text(user.username ?? 'N/A'))),
                      // DataCell(Container(color: Colors.yellow, child: Text(user.uid))),
                      DataCell(Container(color: Colors.yellow, child: Text(user.email))),
                      
                      DataCell(Container(color: Colors.yellow, child: Text(user.address ?? 'N/A'))),
                      // 
                      DataCell(
                        Container(
                          color: Colors.yellow,
                          child: user.imageURL != null
                              ? Image.network(
                            user.imageURL!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                              : Text('N/A'),
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            );
          } else {
            return Text('No users logged in');
          }
        },
      ),
    );
  }
}

class User {
  final String uid;
  final String email;
  final String? username;
  final String? address;
  final String? userId;
  String? imageURL; // Updated to mutable type

  User({
    required this.uid,
    required this.email,
    this.username,
    this.address,
    this.userId,
    this.imageURL,
  });

  factory User.fromMap(Map<String, dynamic>? data) {
    return User(
      uid: data?['uid'] ?? '',
      email: data?['email'] ?? '',
      username: data?['username'],
      address: data?['address'],
      userId: data?['userId'],
      imageURL: data?['imageURL'],
    );
  }
}

Future<String?> fetchImageFromUserFirestore(String userUid) async {
  try {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('userslist')
        .doc(userUid)
        .get();

    if (userSnapshot.exists) {
      // Assuming the image URL is stored in the 'image' field
      return userSnapshot['imageURL'] ?? '';
    } else {
      print('User not found in Firestore for UID: $userUid');
      return null;
    }
  } catch (e) {
    print('Error fetching image from user Firestore: $e');
    return null;
  }
}