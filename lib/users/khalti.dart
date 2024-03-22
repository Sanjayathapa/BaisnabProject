
import 'package:baisnab/users/payment_system/khalti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KhaltiPayment extends StatefulWidget {
  final double recipePrice;
  final String recipeTitle;
  final String recipeId;

  KhaltiPayment(
      {Key? key,
      required this.recipePrice,
      required this.recipeTitle,
      required this.recipeId})
      : super(key: key);

  @override
  _KhaltiPaymentState createState() => _KhaltiPaymentState();
}

class _KhaltiPaymentState extends State<KhaltiPayment> {
  String referenceId = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final address = _addressController.text;
      final email = _emailController.text;
      final phoneNumber = _phoneNumberController.text;

      try {
        await FirebaseFirestore.instance.collection('orders').add({
          'username': username,
          'address': address,
          'email': email,
          'phoneNumber': phoneNumber,

          'recipeTitle': '${widget.recipeTitle}', 
          'recipePrice':
              '${widget.recipePrice.toStringAsFixed(2)}', 
          'timestamp': FieldValue.serverTimestamp(),
        });

        final Email emailMessage = Email(
          subject: 'New Order',
          recipients: ['sandeshthapa2415@gmail.com'],
          body: '''
            Username: $username
            Address: $address
            Email: $email
            Recipe Title: ${widget.recipeTitle}
            Recipe Name: ${widget.recipePrice.toStringAsFixed(2)}
            Phone Number: $phoneNumber
          ''',
        );

        await FlutterEmailSender.send(emailMessage);

        Fluttertoast.showToast(
          msg: 'Order placed successfully!',
          gravity: ToastGravity.BOTTOM, // Display at the bottom
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_LONG,
        );

        
       Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KhaltiiPayment(
          recipePrice: widget.recipePrice,
          recipeTitle: widget.recipeTitle,
          recipeId: '', // Provide the recipe ID here if needed
        ),
      ),
    );
      } catch (e) {
        print('Error: $e');
      }
    }
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
                        decoration:
                            InputDecoration(labelText: 'Phone Number'),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                       
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 40),
                              backgroundColor:
                                  Color.fromARGB(255, 248, 78, 11),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: _placeOrder,
                            child: Text(
                              'Place Order',textAlign: TextAlign.start,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 252, 249, 249),
                                fontSize: 16,
                                
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                         
                        ],
                      )
                    ],
                  ),
                ),
                Center(
                    child:
                        Text("Payment Amount: ${widget.recipePrice.toStringAsFixed(2)}", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),)),
                        Text('RecipeTitle: ${widget.recipeTitle}' ,style: TextStyle(
                                  
                                    fontWeight: FontWeight.bold,
                                  ),)
              ],
            ),
          ),
        ),
      ),
    );
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
}
