import 'package:baisnab/services/rating.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../theme.dart/theme.dart';

class MyScreen extends StatefulWidget {
  final String username; // Username associated with authenticated user

  MyScreen({required this.username});

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? displayName;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
    
      } else {
       
        setState(() {
          displayName = user.displayName;
        });
      }
    });
  }

  @override
  
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);
    return Consumer<ThemeNotifier>(builder: (context, themeProvider, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getTheme(),
          home: SafeArea(
          child: Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
    icon: const Icon(Icons.arrow_back_ios_sharp),
    onPressed: () {
      Navigator.of(context).pop();
    },
  ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('username', isEqualTo: widget.username)
            .snapshots(),
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
              Order order = Order.fromMap(orderData);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  shadowColor: Color.fromARGB(255, 255, 184, 231),
                  color: Color.fromARGB(255, 244, 213, 249),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          ' ${order.username}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (order.recipeTitle != null &&
                                order.recipeTitle.isNotEmpty)
                              Text(
                                'Recipe: ${order.recipeTitle}',
                                style: TextStyle(
                                  fontSize: 15, color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (order.recipePrice != null &&
                                order.recipeTitle.isNotEmpty)
                              Text(
                                'Price: \$${order.recipePrice?.toStringAsFixed(2)}\n',
                                style: TextStyle(
                                  fontSize: 16, color: Colors.black
                                ),
                              ),
                            Text(
                              'Order Date: ${order.timestamp.toDate()}', style: TextStyle(
                            color: Colors.black),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('sendresponse')
                                  .where('recipeTitle',
                                      isEqualTo: order.recipeTitle)
                                  .snapshots(),
                              builder: (context, msgSnapshot) {
                                if (msgSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (msgSnapshot.hasError) {
                                  return Text(
                                      'Error fetching message: ${msgSnapshot.error}',);
                                }
                                var msgDocs = msgSnapshot.data?.docs ?? [];
                                var msg = msgDocs.isNotEmpty
                                    ? msgDocs.first['msg']
                                    : 'No message available';
                                return Text(
                                  'Message: $msg', style: TextStyle(
                            color: Colors.black)
                                );
                              },
                            ),
                            Row(
                              children: [
                                StarRating(
                                  initialRating: 0, // Set initial rating to 0
                                  username: order.username,
                                  recipeTitle: order.recipeTitle,
                                ),
                              ],
                            ),
                            ...order.items.map((item) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Quantity: ${item['quantity']}',  style: TextStyle(
                            color: Colors.black),
                            ),
                                  Divider(),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 13),
                            child: InkWell(
                              onTap: () {
                                _cancelOrder(context, order.recipeTitle);
                              },
                              child: Text(
                                'Cancel Order',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 13),
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                _deleteItem(context, order.recipeTitle,
                                    order.recipePrice);
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
    )
        )
       );
    }
        );
  }

  void _cancelOrder(BuildContext context, String? recipeTitle) async {
    if (recipeTitle == null) return;

    // Update Firestore with the cancelled order message
    await FirebaseFirestore.instance.collection('sendresponse').add({
      'recipeTitle': recipeTitle,
      'msg': 'Your order for $recipeTitle has been cancelled.',
      'timestamp': Timestamp.now(),
    });

    // Store the cancellation message in the 'orders' collection and replace any existing message
    await FirebaseFirestore.instance
        .collection('orders')
        .where('recipeTitle', isEqualTo: recipeTitle)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.update({
          'msg': 'Your order for $recipeTitle has been cancelled.',
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order cancelled for $recipeTitle.'),
      ),
    );
  }

  void _deleteItem(
      BuildContext context, String recipeTitle, double? recipePrice) async {
    // Delete from 'orders' collection
    await FirebaseFirestore.instance
        .collection('orders')
        .where('recipeTitle', isEqualTo: recipeTitle)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    // Delete from 'sendresponse' collection
    await FirebaseFirestore.instance
        .collection('sendresponse')
        .where('recipeTitle', isEqualTo: recipeTitle)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item with recipe title $recipeTitle deleted.'),
          backgroundColor: Color.fromARGB(255, 243, 3, 3),
      ),
    );
  }
}

class Order {
  final String username;
  final String recipeTitle;
  final double? recipePrice;
  final Timestamp timestamp;
  final List<Map<String, dynamic>> items;

  Order({
    required this.username,
    required this.recipeTitle,
    this.recipePrice,
    required this.timestamp,
    required this.items,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      username: map['username'] ??
          '', // Provide a default value if 'username' is null
      recipeTitle: map['recipeTitle'] ??
          '', // Provide a default value if 'recipeTitle' is null
      recipePrice:
          map['recipePrice']?.toDouble(), // Convert to double if not null
      timestamp: map['timestamp'] ??
          Timestamp.now(), // Provide a default value if 'timestamp' is null
      items: List<Map<String, dynamic>>.from(map['items'] ?? []),
    );
  }
}
