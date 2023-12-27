import 'package:baisnab/Admin/recipelist.dart';
import 'package:baisnab/Admin/userlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String username;
  final String address;
  final String email;
  final String phoneNumber;
  final String recipeTitle;
  final double recipePrice;
  final Timestamp timestamp;

  Order({
    required this.username,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.recipeTitle,
    required this.recipePrice,
    required this.timestamp,
  });
    factory Order.fromMap(Map<String, dynamic>? data) {
    return Order(
      username: data?['username'] ?? '',
      address: data?['address'] ?? '',
      email: data?['email'] ?? '',
      phoneNumber: data?['phoneNumber'] ?? '',
      recipeTitle: data?['recipeTitle'] ?? '',
      recipePrice: data?['recipePrice']?.toDouble() ?? 0.0,
      timestamp: data?['timestamp'] as Timestamp? ?? Timestamp.now(),
    );
  }
}


class OrderListScreen extends StatelessWidget {
Future<void> _deleteItem(BuildContext context, String recipeId, String recipeTitle) async {
  try {
    await FirebaseFirestore.instance.collection('orders')
        .where('recipeId', isEqualTo: recipeId)
        .where('recipeTitle', isEqualTo: recipeTitle)
        .get()
        .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.delete();
          });
        });
  } catch (e) {
    print('Error deleting recipe: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Recipe List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminRecipeList(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('User List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Add Recipe'),
              onTap: () {
                // Handle navigation to Add Recipe Screen
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var orders = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var orderData = orders[index].data() as Map<String, dynamic>;

              Order order = Order(
                username: orderData['username'] ?? '',
                address: orderData['address'] ?? '',
                email: orderData['email'] ?? '',
                phoneNumber: orderData['phoneNumber'] ?? '',
                recipeTitle: orderData['recipeTitle'] ?? '',
                recipePrice: double.parse(orderData['recipePrice'] ?? '0.0'),
                timestamp: (orderData['timestamp'] ?? Timestamp.now()) as Timestamp,
              );

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  shadowColor: Colors.tealAccent,
                  color: const Color(0xFFF4F5FE),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Recipe: ${order.recipeTitle}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Price: \$${order.recipePrice.toStringAsFixed(2)}\n'
                          'User: ${order.username}\n'
                          'Address: ${order.address}\n'
                          'Email: ${order.email}\n'
                          'Phone Number: ${order.phoneNumber}\n'
                          'Order Date: ${order.timestamp.toDate()}',
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                _deleteItem(context, orderData['recipeId'],orderData['recipeTitle']);
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
