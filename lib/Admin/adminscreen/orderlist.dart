import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Order {
  final String userId;
  final String username;
  final String address;
  final String phoneNumber;
  final double latitude;
  final String recipeTitle;
  final double recipePrice;
  final double longitude;
  final List<Map<String, dynamic>> items;
  final String msg;
  final Timestamp timestamp;

  Order({
    required this.userId,
    required this.username,
    required this.recipeTitle,
    required this.recipePrice,
    required this.address,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.items,
    required this.msg,
    required this.timestamp,
  });

  factory Order.fromMap(Map<String, dynamic>? data) {
    return Order(
      userId: data?['userId'] ?? '',
      recipeTitle: data?['recipeTitle'] ?? '',
recipePrice: (data?['recipePrice'] is String) ? double.parse(data?['recipePrice']!) : (data?['recipePrice'] ?? 0.0),

      username: data?['username'] ?? '',
      address: data?['address'] ?? '',
      phoneNumber: data?['phoneNumber'] ?? '',
      latitude: data?['latitude']?.toDouble() ?? 0.0,
      longitude: data?['longitude']?.toDouble() ?? 0.0,
      items: List<Map<String, dynamic>>.from(data?['items'] ?? []),
      msg: data?['msg'] ?? '',
      timestamp: data?['timestamp'] as Timestamp? ?? Timestamp.now(),
    );
  }
}

class OrderListScreen extends StatelessWidget {
Future<void> _deleteItem(BuildContext context, String recipeTitle,double recipePrice) async {
  try {
   
    final querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('recipeTitle', isEqualTo: recipeTitle)
        .get();

    print('Found ${querySnapshot.docs.length} documents with recipeTitle at top level');

   
    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    print('Order(s) with recipeTitle $recipeTitle deleted successfully.');
  } catch (e) {
    print('Error deleting order: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to delete order: $e'),
      backgroundColor: Colors.red,
    ));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order list',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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

              Order order = Order.fromMap(orderData);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  shadowColor: Colors.tealAccent,
                  color: Color.fromARGB(255, 245, 251, 251),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'User: ${order.username}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address: ${order.address}',
                            ),
                             Text(
                              'Phone Number: ${order.phoneNumber}',
                            ),
                             Divider(),
                            if (order.recipeTitle != null &&
                                order.recipeTitle.isNotEmpty)
                              Text(
                                'Recipe: ${order.recipeTitle}',
                                style: TextStyle(
                                  fontSize:15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (order.recipePrice != null &&
                                order.recipeTitle.isNotEmpty)
                              Text(
                                'Price: \$${order.recipePrice.toStringAsFixed(2)}\n',
                                style: TextStyle(
                                  fontSize: 16,
                                ),),
                              
                           
                            Text(
                              'Order Date: ${order.timestamp.toDate()}',
                            ),
                           
                           
                            ...order.items.map((item) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 
                                  Text('Quantity: ${item['quantity']}'),
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
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                _deleteItem(context, order.recipeTitle, order.recipePrice);
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
