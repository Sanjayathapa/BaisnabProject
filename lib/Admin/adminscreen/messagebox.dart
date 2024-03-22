import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:custom_clippers/custom_clippers.dart';

import '../providers/dark_theme_provider.dart';


class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<MessageCountProvider>(
          builder: (context, provider, child) {
            return Row(
              children: [
                Text('Message Box'),
                SizedBox(width: 10),
                if (provider.newMessageCount > 0)
                  Badge(
                    // badgeContent: Text(
                    //   provider.newMessageCount.toString(),
                    //   style: TextStyle(color: Colors.white),
                    // ),
                  ),
              ],
            );
          },
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

              return OrderCard(
                order: Order.fromMap(orderData),
                onTap: () {
                  _acceptOrder(
                      context, orderData['recipeTitle'], orderData['msg']);
                },
              );
            },
          );
        },
      ),
    );
  }
 Widget _buildBadge(int count) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      constraints: BoxConstraints(
        minWidth: 16,
        minHeight: 16,
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _acceptOrder(BuildContext context, String recipeTitle, String msg) async {
    final provider = Provider.of<MessageCountProvider>(context, listen: false);
    provider.incrementMessageCount();

    // Update Firestore with the accepted order message
    await FirebaseFirestore.instance.collection('sendresponse').add({
      'recipeTitle': recipeTitle,
      'msg': 'Your order for $recipeTitle has been accepted. $msg',
      'timestamp': Timestamp.now(),
    });

   
    await FirebaseFirestore.instance.collection('orders').where('recipeTitle', isEqualTo: recipeTitle).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

   
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Order accepted for $recipeTitle.'),
    ));
  }
}


class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const OrderCard({
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipPath(
        clipper: LowerNipMessageClipper(
          MessageType.receive,
        ),
        child: Container(
          width: 250,
          color: Color.fromARGB(228, 8, 123, 2),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                if (order.recipeTitle != null &&
                    order.recipeTitle!.isNotEmpty &&
                    order.recipePrice != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
              'User: ${order.username}'
              ,
                        style: TextStyle(
                          fontSize: 15, color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                         Text(
              'Message: ${order.msg}',style: TextStyle(
                          fontSize: 15, color: Colors.white,
                          
                        ),
            ),
                     
                      Text(
                        'Price: \$${order.recipePrice!.toStringAsFixed(2)}\n',
                        style: TextStyle(
                          fontSize: 15,color: Colors.white,
                        ),
                      ),
                    ],
                  )
              ],
            ),
            
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}

class Order {
  final String username;
  final String msg;
  final List<Map<String, dynamic>>? items;
  final String? recipeTitle;
  final double? recipePrice; // Add recipePrice property here

  Order({
    required this.username,
    required this.msg,
    this.items,
    this.recipeTitle,
    this.recipePrice, // Include recipePrice parameter in the constructor
  });

  factory Order.fromMap(Map<String, dynamic> data) {
    return Order(
      username: data['username'] ?? '',
      msg: data['msg'] ?? '',
     
      recipeTitle: data['recipeTitle'],
      recipePrice: data['recipePrice'] != null
          ? double.parse(data['recipePrice'].toString())
          : null, // Parse recipePrice as double
    );
  }
}
