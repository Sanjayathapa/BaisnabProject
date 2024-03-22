import 'package:baisnab/googlemap/googlemap.dart';
import 'package:baisnab/model/model.dart';
import 'package:baisnab/services/send_notification.dart';

import 'package:baisnab/users/khalti.dart';
import 'package:baisnab/users/payment_system/khalti.dart';
import 'package:baisnab/users/profile/profile_screen.dart';
import 'package:baisnab/users/screens/cartpage/addfvorite.dart';
import 'package:baisnab/users/screens/home_screen.dart';
import 'package:baisnab/users/theme.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:baisnab/data/recipelist.dart';

import 'package:firebase_auth/firebase_auth.dart';

class CartPage extends StatefulWidget {
  final String recipeTitle;

  CartPage({required this.recipeTitle, required this.context});
  final BuildContext context;

  @override
  _CartPageState createState() => _CartPageState(recipeTitle: recipeTitle);
}

class _CartPageState extends State<CartPage> {
  final String recipeTitle;

  _CartPageState({required this.recipeTitle});
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int counter = 1;

  void incrementCounter() {
    // Use setState to update the state and trigger a rebuild of the widget.
    setState(() {
      counter++;
    });
  }

  Future<void> _updateQuantity(
      BuildContext context, String recipeId, int newQuantity) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference cartCollection =
          firestore.collection('users').doc(user.uid).collection('cart');

      // Fetch the current cart item
      final DocumentSnapshot docSnapshot =
          await cartCollection.doc(recipeId).get();

      if (docSnapshot.exists) {
        final double initialPrice =
            docSnapshot['recipename'] ?? 0.0; // Get the initial price

        // Ensure that the new quantity is never below 1
        if (newQuantity < 1) {
          newQuantity = 1;
        }

        final double newPrice =
            initialPrice * newQuantity; // Calculate the new price

        // Update the quantity and price in Firestore
        await cartCollection.doc(recipeId).update({
          'quantity': newQuantity,
          'price': newPrice,
        });
      }
    }
  }

  Future<void> _placeOrder(
      double recipePrice, String recipeName, int quantity) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Retrieve user details from Firestore
    final userSnapshot = await FirebaseFirestore.instance
        .collection('userslist')
        .doc(userId)
        .get();
    final username = userSnapshot['username'];
    final address = userSnapshot['address'];
    final phoneNumber = userSnapshot['phoneNumber'];
    final latitude = userSnapshot['latitude'];
    final longitude = userSnapshot['longitude'];

    try {
      // Store order details in Firestore
      await FirebaseFirestore.instance.collection('orders').add({
        'userId': userId,
        'username': username,
        'address': address,
        'phoneNumber': phoneNumber,
        'latitude': latitude,
        'longitude': longitude,
        'recipeTitle': recipeName,
        'recipePrice': recipePrice,
        'items': [
          {
            'quantity': quantity,
          }
        ],
        'msg': 'You have a new order for $recipeName',
        'timestamp': FieldValue.serverTimestamp(),
      });
// await _deleteItem(context, widget.recipeTitle);
      Fluttertoast.showToast(
        msg: 'Order placed successfully!',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_LONG,
      );
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
        msg: 'Failed to place order. Please try again.',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context, listen: false);
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeNotifier>(context).getTheme(),
        home: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            body: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_sharp),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      child: Text(
                        "Cart page",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 100),
                  ],
                ),
              
                Expanded(
                  child: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, authSnapshot) {
                      if (authSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (authSnapshot.hasError) {
                        return Text(
                            'Authentication Error: ${authSnapshot.error}');
                      }

                      final user = FirebaseAuth.instance.currentUser;

                      if (user == null) {
                        return Center(
                          child: Text('You need to log in to view your cart.'),
                        );
                      }

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .collection('cart')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text('Your cart is empty.'),
                            );
                          }

                          List<Recipe> recipes = snapshot.data!.docs.map((doc) {
                            final rating = (doc.data()
                                as Map<String, dynamic>?)?['rating'];
                            final quantity = (doc.data()
                                as Map<String, dynamic>?)?['quantity'];
                            final price =
                                (doc.data() as Map<String, dynamic>?)?['price'];

                            if (quantity == null || price == null) {
                              // Handle missing data or incomplete documents
                              return Recipe(
                                recipeTitle: doc['recipeTitle'],
                                cookingTime: doc['cookingTime'],
                                description: doc['description'],
                                image: doc['image'],
                                rating: rating,
                                index: doc['index'],
                                recipeId: doc.id,
                                // recipename: doc['recipename'],
                                quantity: 1, // Default quantity when missing
                                recipename: doc[
                                    'recipename'], // Default price when missing
                              );
                            }

                            return Recipe(
                              recipeTitle: doc['recipeTitle'],
                              cookingTime: doc['cookingTime'],
                              description: doc['description'],
                              index: doc['index'],

                              image: doc['image'],
                              rating: rating,
                              recipeId: doc.id,
                              // recipename: doc['recipename'],
                              quantity: quantity,
                              recipename: price,
                            );
                          }).toList();

                          return ListView.builder(
                            itemCount: recipes.length,
                            itemBuilder: (context, index) {
                              final recipe = recipes[index];

                              return ListTile(
                                title: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        buildRecipeImagee(recipe),
                                        // Image.asset(
                                        //   recipe.image,
                                        //   width: 55,
                                        //   height: 60,
                                        //   fit: BoxFit.cover,
                                        // ),
                                        SizedBox(width: 10, height: 30),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 45),
                                            Text(
                                              recipe.recipeTitle,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Price: NRS ${recipe.initialPrice != null ? '\$${recipe.initialPrice.toStringAsFixed(2)}' : recipe.recipename}',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.remove),
                                                  onPressed: () {
                                                    _updateQuantity(
                                                        context,
                                                        recipe.recipeId,
                                                        recipe.quantity - 1);
                                                  },
                                                ),
                                                Text(
                                                  'Quantity: ${recipe.quantity}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    _updateQuantity(
                                                        context,
                                                        recipe.recipeId,
                                                        recipe.quantity + 1);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            _deleteItem(
                                                context, recipe.recipeId);
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(138, 36),
                                            backgroundColor: Color.fromARGB(
                                                255, 248, 78, 11),
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            _placeOrder(
                                                recipe.recipename ?? 0.0,
                                                recipe.recipeTitle,
                                                recipe.quantity);
                                             NotificationService().sendNotification(
                                                    "Baisnab", 
                                                    "You have a new order", 
                                                  );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    KhaltiiPayment(
                                                  recipePrice:
                                                      recipe.recipename ?? 0.0,
                                                  recipeTitle:
                                                      recipe.recipeTitle,
                                                  recipeId: recipe.recipeId,
                                                ),
                                                // OrderConfirmationScreen(
                                                //   recipeTitle: recipe.recipeTitle,
                                                //   recipename: '',
                                                // ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Place order',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(156, 36),
                                            backgroundColor: Color.fromARGB(
                                                255, 167, 4, 107),
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    KhaltiPayment(
                                                  recipePrice:
                                                      recipe.recipename ?? 0.0,
                                                  recipeTitle:
                                                      recipe.recipeTitle,
                                                  recipeId: recipe.recipeId,
                                                ),
                                                // OrderConfirmationScreen(
                                                //   recipeTitle: recipe.recipeTitle,
                                                //   recipename: '',
                                                // ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Gift to Others',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                  Text("Note: Selected recipe will not deleted from the cart page if you didnot pay online. In Your CartPage your order recipe will remain same for to checkout recipe for reorder.And it will store on the cart page until you didnot delete it",
                  style: TextStyle(fontSize: 9, 
                  color:Colors.red,fontWeight: FontWeight.bold),),
                
              ],
            ),
            bottomNavigationBar: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFFAF5E1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              recipeMenu: [],
                              title: '',
                            ),
                          ));
                    },
                    icon: const Icon(
                      Icons.home,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoritePage(
                            recipes: [],
                            recipeId: '',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CartPage(recipeTitle: '', context: context),
                          ));
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      Navigator.push(
                        context as BuildContext,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> _deleteItem(BuildContext context, String recipeId) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference cartCollection =
          firestore.collection('users').doc(user.uid).collection('cart');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Item'),
            content: Text('Are you sure you want to delete this item?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  try {
                    await cartCollection.doc(recipeId).delete();
                    // setState(() {});
                  } catch (e) {
                    print('Error deleting recipe: $e');
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }
}

Widget buildRecipeImagee(Recipe recipe) {
  if (recipe.image != null && recipe.image.startsWith('https://')) {
    // Image is a network image
    return Image.network(
      recipe.image,
      fit: BoxFit.cover,
      width: 70,
      height: 80,
    );
  } else if (recipe.image != null && recipe.image.startsWith('assets/')) {
    // Image is from assets
    return Image.asset(
      recipe.image,
      fit: BoxFit.cover,
      width: 55,
      height: 60,
    );
  } else {
    return Image.asset(
      recipe.image, // Replace with your default image path
      fit: BoxFit.cover,
      width: 55,
      height: 60,
    );
  }
}
