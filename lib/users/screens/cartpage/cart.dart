import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final String recipeTitle;
  final String recipename;

  OrderConfirmationScreen({
    required this.recipeTitle,
    required this. recipename,
  });

  @override
  _OrderConfirmationScreenState createState() =>
      _OrderConfirmationScreenState();
}


class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (_formKey.currentState!.validate()) {
      // Get order details from form
      final username = _usernameController.text;
      final address = _addressController.text;
      final email = _emailController.text;
      final phoneNumber = _phoneNumberController.text;
      final quantity = _quantityController.text;
       _usernameController.clear();
        _addressController.clear();
        _emailController.clear();
        _phoneNumberController.clear();
        _quantityController.clear();
      try {
        // Store order in Firestore
        await FirebaseFirestore.instance.collection('orders').add({
          'username': username,
          'address': address,
          'email': email,
          'phoneNumber': phoneNumber,
          'quantity': quantity,
          
          'recipeTitle': widget.recipeTitle,
          'recipePrice': widget.recipename,
          'timestamp': FieldValue.serverTimestamp(),
        
        });

        // Send email notification to the manager
       var recipeTitle;
       var recipename;
       final Email emailMessage = Email(
  subject: 'New Order',
  recipients: [
    'sandeshthapa2415@gmail.com'
  ], // Replace with the manager's email
  body: '''
    Username: $username
    Address: $address
    Email: $email
    Recipe Title: $recipeTitle
    Recipe Name: $recipename
    Phone Number: $phoneNumber
    Quantity: $quantity
  ''',
);

        await FlutterEmailSender.send(emailMessage);

        // Show a toast message to the user
        Fluttertoast.showToast(
          msg: 'Order placed successfully!',
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_LONG,
        );

        // Clear the form after a successful order placement
      
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    if (value.length < 6) {
      return 'Username is too short';
    }
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Username should not contain numbers';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone Number should contain only numbers';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: 30,
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
                        horizontal: 70,
                        vertical: 15,
                      ),
                      child: Text(
                        "Order form",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        validator: _validateUsername,
                        decoration: InputDecoration(labelText: 'Username'),
                      ),
                      TextFormField(
                        controller: _addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Address is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Address'),
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        controller: _phoneNumberController,
                        validator: _validatePhoneNumber,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                      ),
                      TextFormField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Quantity is required';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Quantity should contain only numbers';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Quantity'),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(160, 50),
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _placeOrder,
                        child: const Text(
                          'Place Order',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
