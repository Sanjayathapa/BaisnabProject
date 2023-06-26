// import 'package:firebase_auth101/screens/menue.dart/recipe1.dart';
// import 'package:flutter/material.dart';

// class Recipes {
//   String recipeTitle;
//   String recipename;

//   Recipes({
//     required this.recipeTitle,
//     required this.recipename,
//   });
// }

// class AddToCartPage extends StatelessWidget {
//   final Recipes recipe;

//   const AddToCartPage({Key? key, required this.recipe}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(
//         title: Text('Add to Cart'),
//       ),
//       body: Column(
//         children: [
//           ListTile(
//             title: Text(recipe.recipeTitle),
//             subtitle: Text('Price: \$${recipe.recipename}'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context, recipe);
//             },
//             child: Text('Add to Cart'),
//           ),
//         ],
//       ),
//     ));
//   }
// }

// class CartItem {
//   Recipe recipe;
//   bool selected;

//   CartItem({
//     required this.recipe,
//     this.selected = false,
//   });
// }

// class CartPage extends StatefulWidget {
//   final List<CartItem> cartItems;

//   const CartPage({Key? key, required this.cartItems, required Recipe recipe}) : super(key: key);

//   @override
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   void removeCartItem(int index) {
//     setState(() {
//       widget.cartItems.removeAt(index);
//     });
//   }

//   void toggleSelect(int index) {
//     setState(() {
//       widget.cartItems[index].selected = !widget.cartItems[index].selected;
//     });
//   }

//   void deleteSelectedItems() {
//     setState(() {
//       widget.cartItems.removeWhere((item) => item.selected);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: deleteSelectedItems,
//             child: Text('Delete Selected'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.cartItems.length,
//               itemBuilder: (context, index) {
//                 CartItem cartItem = widget.cartItems[index];

//                 return ListTile(
//                   title: Text(cartItem.recipe.recipeTitle),
//                   subtitle: Text('Price: \$${cartItem.recipe.recipename}'),
//                   trailing: Checkbox(
//                     value: cartItem.selected,
//                     onChanged: (value) => toggleSelect(index),
//                   ),
//                   onTap: () {
//                     // Handle tapping on the cart item
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast, Toast;

import 'package:flutter_email_sender/flutter_email_sender.dart';

// import 'package:google_fonts/google_fonts.dart';
import '../menue.dart/recipe1.dart';


class Recipe {
  final String recipeTitle;
  final String recipename;

  Recipe({required this.recipeTitle, required this.recipename});
}

class Fluttertoast {
  static void showToast({required String msg, required ToastLength toastLength, required ToastGravity gravity, required MaterialAccentColor backgroundColor, required Enum time, required Color textColor}) {
    // Mock implementation for demonstration purposes
    print('Toast Message: $msg');
  }
}

enum ToastLength { SHORT, LONG }

enum ToastGravity { TOP, CENTER, BOTTOM }


class CartItem {
  final Recipe recipe;
  final int quantity;

  CartItem({required this.recipe, required this.quantity});
}

class OrderFormPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const OrderFormPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _OrderFormPageState createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  int _quantity = 1;

  @override
  void dispose() {
    _usernameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (_formKey.currentState!.validate()) {
      // Check if username meets the criteria
      String username = _usernameController.text;
      if (username == '123' || !username.startsWith('') || !isAlpha(username)) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Invalid Username'),
              content: const Text(
                  'The username should start with "abc" and contain only letters.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      // Store the order in Firestore
      FirebaseFirestore.instance.collection('orders').add({
        'username': _usernameController.text,
        'address': _addressController.text,
        'phoneNumber': _phoneNumberController.text,
        'orderItems': widget.cartItems
            .map((item) => {
                  'recipeTitle': item.recipe.recipeTitle,
                  'recipePrice': item.recipe.recipename,
                  'quantity': item.quantity,
                })
            .toList(),
      });

      // Send email to the owner
      final Email email = Email(
        subject: 'New Order',
        recipients: ['sandeshthapa2415@gmail.com'], // Replace with the owner's email address
        body: '''
          Username: ${_usernameController.text}
          Address: ${_addressController.text}
          Phone Number: ${_phoneNumberController.text}
          Quantity: $_quantity
          Order Items: ${widget.cartItems.map((item) => '${item.recipe.recipeTitle} - ${item.quantity}').join('\n')}
        ''',
      );

      try {
        await FlutterEmailSender.send(email);
      } catch (e) {
          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:  Text('Error sending email: $e'),
                                  
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
       
      }

    Fluttertoast.showToast(
  msg: 'Order placed successfully!',
 
  gravity: ToastGravity.CENTER,
  time: Toast.LENGTH_SHORT,
  backgroundColor: Colors.greenAccent,
  textColor: Colors.black, toastLength: ToastLength.LONG,
);

      // Clear the cart after placing the order
      // widget.cartItems.clear();
    }
  }

  bool isAlpha(String str) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                        color: Colors.black,
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
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        if (value.length < 6) {
                          return 'Too short';
                        }
                        if (RegExp(r'\d').hasMatch(value)) {
                          return 'Username should not contain numbers';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an address';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(labelText: 'Phone Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantity: $_quantity'),
                        DropdownButton<int>(
                          value: _quantity,
                          onChanged: (value) {
                            setState(() {
                              _quantity = value!;
                            });
                          },
                          items: List.generate(10, (index) => index + 1)
                              .map(
                                (value) => DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(230, 50),
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _placeOrder,
                      child: const Text(
                        'Place Order',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
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
    );
  }
}


// class Recipe {
//   final String recipeTitle;
//   final double recipePrice;

//   Recipe({required this.recipeTitle, required this.recipePrice});
// }

// class CartItem {
//   final Recipe recipe;
//   final int quantity;

//   CartItem({required this.recipe, required this.quantity});
// }

// class OrderFormPage extends StatefulWidget {
//   final List<CartItem> cartItems;

//   const OrderFormPage({Key? key, required this.cartItems}) : super(key: key);

//   @override
//   _OrderFormPageState createState() => _OrderFormPageState();
// }

// class _OrderFormPageState extends State<OrderFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   int _quantity = 1;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _addressController.dispose();
//     _phoneNumberController.dispose();
//     super.dispose();
//   }

//   Future<void> _placeOrder() async {
//     if (_formKey.currentState!.validate()) {
//       // Check if username meets the criteria
//       String username = _usernameController.text;
//       if (username == '123' || !username.startsWith('') || !isAlpha(username)) {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Invalid Username'),
//               content: const Text(
//                   'The username should start with "abc" and contain only letters.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//         return;
//       }

//       // // Get the current location
//       // Position? position = await Geolocator.getCurrentPosition(
//       //   desiredAccuracy: LocationAccuracy.high,
//       // );

//       // // Extract latitude and longitude
//       // double latitude = position.latitude;
//       // double longitude = position.longitude;

//       // Store the order in Firestore
//       FirebaseFirestore.instance.collection('orders').add({
//         'username': _usernameController.text,
//         'address': _addressController.text,
//         'phoneNumber': _phoneNumberController.text,
//         // 'latitude': latitude,
//         // 'longitude': longitude,
//         'orderItems': widget.cartItems
//             .map((item) => {
//                   'recipeTitle': item.recipe.recipeTitle,
//                   'recipePrice': item.recipe.recipename,
//                   'quantity': item.quantity,
//                 })
//             .toList(),
//       });

//       Fluttertoast.showToast(
//         msg: 'Order placed successfully!',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//       );

//       // Clear the cart after placing the order
//       widget.cartItems.clear();
//     }
//   }

//   bool isAlpha(String str) {
//     return RegExp(r'^[a-zA-Z]+$').hasMatch(str);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: SingleChildScrollView
//     (
//       padding: const EdgeInsets.all(16),
//       child: Column(children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SizedBox(
//                 height: 50,
//                 width: 30,
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_back_ios_sharp),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 70,
//                   vertical: 15), // Replace `8.0` with your desired margin value
// //  GoogleFonts.lato
//               child: Text(
//                 "Order form ",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(labelText: 'Username'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a username';
//                   }
//                   if (value.length < 6) {
//                     return 'Too short';
//                   }
//                   if (RegExp(r'\d').hasMatch(value)) {
//                     return 'Username should not contain numbers';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _addressController,
//                 decoration: const InputDecoration(labelText: 'Address'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an address';
//                   }

//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _phoneNumberController,
//                 decoration: const InputDecoration(labelText: 'Phone Number'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a phone number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Quantity: $_quantity'),
//                   DropdownButton<int>(
//                     value: _quantity,
//                     onChanged: (value) {
//                       setState(() {
//                         _quantity = value!;
//                       });
//                     },
//                     items: List.generate(10, (index) => index + 1)
//                         .map((value) => DropdownMenuItem<int>(
//                               value: value,
//                               child: Text(value.toString()),
//                             ))
//                         .toList(),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(230, 50),
         
//                          backgroundColor: Colors.greenAccent, // Set the background color
//                     foregroundColor: Colors.white, // Set the text color
//                   ),
//                 onPressed: _placeOrder,
//                 child: const Text('Place Order',
//                  style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),),
//               ),
//             ],
//           ),
//         ),
//       ]),
//     )));
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Order App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CartPage(
//         cartItems: [
//           CartItem(
//             recipe: Recipe(recipeTitle: 'Recipe 1', recipename: "10.0", cookingTime: '', image: '', description: '', readingTime: ''),
//             quantity: 1,
//           ),
//           CartItem(
//             recipe:Recipe(recipeTitle: 'Recipe 1', recipename: "10.0", cookingTime: '', image: '', description: '', readingTime: ''),
//             quantity: 2,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CartPage extends StatelessWidget {
//   final List<CartItem> cartItems;

//   const CartPage({Key? key, required this.cartItems}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           CartItem cartItem = cartItems[index];

//           return ListTile(
//             title: Text(cartItem.recipe.recipeTitle),
//             subtitle: Text('Price: \$${cartItem.recipe.recipename.toStringAsFixed(2)}'),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => OrderFormPage(cartItems: cartItems),
//             ),
//           );
//         },
//         child: Icon(Icons.shopping_cart),
//       ),
//     );
//   }
// }



// CartPage(cartItems: []),