
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
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
    Khalti.init(publicKey: 'test_public_key_ce2f2ab40248417dbe23b8f447466984');
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

        
        Navigator.pop(context);
      } catch (e) {
        print('Error: $e');
      }
    }
  }
void _handlePaymentAndDelete(BuildContext context) async {
  await payWithKhaltiInApp();

 
  await _deleteItem(context, widget.recipeTitle);
}

Future<void> _deleteItem(BuildContext context, String recipeTitle) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  if (user != null) {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference cartCollection =
          firestore.collection('users').doc(user.uid).collection('cart');

    
      final QuerySnapshot querySnapshot = await cartCollection
          .where('recipeTitle', isEqualTo: recipeTitle)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

    
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       title: Text('Payment Successful'),
      //       actions: [
      //         SimpleDialogOption(
      //           child: Text('OK'),
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //         )
      //       ],
      //     );
      //   },
      // );
    } catch (error) {
      print('Error deleting item: $error');
   
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
                          Column(
                            children: [
                              SizedBox(height: 21),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(167, 40),
                                  backgroundColor:
                                      Color.fromARGB(255, 173, 62, 252),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                   _handlePaymentAndDelete(context);
                                        
                                },
                                child: Text(
                                  "Pay with Khalti",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          )
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

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: (widget.recipePrice * 100).toInt(),
        productIdentity: widget.recipeId,
        productName: widget.recipeTitle,
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
        PaymentPreference.connectIPS,
        PaymentPreference.eBanking,
        PaymentPreference.sct,
        PaymentPreference.mobileBanking,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) async {
    setState(() {
      referenceId = success.idx;
    });

    // Delete the recipe details from Firestore
  await _deleteItem(context, widget.recipeId);
    // Navigate back to the home page
    Navigator.pop(context);

    // Show a success toast message
    Fluttertoast.showToast(
      msg: 'Payment Successful!',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.greenAccent,
      textColor: Colors.black,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  void onFailure(PaymentFailureModel failure) {
    print('Payment Failure: ${failure.message}');
  }

  void onCancel() {
    debugPrint('Cancelled');
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
