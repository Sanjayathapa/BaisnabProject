import 'package:baisnab/googlemap/googlemap.dart';
import 'package:baisnab/model/model.dart';
import 'package:baisnab/screens/cartpage/addfvorite.dart';
import 'package:baisnab/screens/cartpage/cart.dart';
import 'package:baisnab/screens/payment_system/khalti.dart';
import 'package:baisnab/screens/theme.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baisnab/data/recipelist.dart';
import 'package:baisnab/screens/home_screen.dart';
import 'package:baisnab/screens/profile/profile_screen.dart';
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
Future<void> _updateQuantity(BuildContext context, String recipeId, int newQuantity) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  if (user != null) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference cartCollection = firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart');

    // Fetch the current cart item
    final DocumentSnapshot docSnapshot = await cartCollection.doc(recipeId).get();

    if (docSnapshot.exists) {
      final double initialPrice = docSnapshot['recipename'] ?? 0.0; // Get the initial price

      // Ensure that the new quantity is never below 1
      if (newQuantity < 1) {
        newQuantity = 1;
      }

      final double newPrice = initialPrice * newQuantity; // Calculate the new price

      // Update the quantity and price in Firestore
      await cartCollection.doc(recipeId).update({
        'quantity': newQuantity,
        'price': newPrice,
      });

      setState(() {});
    }
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
                      if (authSnapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (authSnapshot.hasError) {
                        return Text('Authentication Error: ${authSnapshot.error}');
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

                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text('Your cart is empty.'),
                            );
                          }

                          List<Recipe> recipes = snapshot.data!.docs.map((doc) {
                            final rating = (doc.data() as Map<String, dynamic>?)?['rating'];
                            final quantity = (doc.data() as Map<String, dynamic>?)?['quantity'];
                            final price = (doc.data() as Map<String, dynamic>?)?['price'];

                            // Check if quantity and price fields exist in the document
                            if (quantity == null || price == null) {
                              // Handle missing data or incomplete documents
                              return Recipe(
                                recipeTitle: doc['recipeTitle'],
                                cookingTime: doc['cookingTime'],
                                description: doc['description'],
                                image: doc['image'],
                                rating: rating,
                                recipeId: doc.id,
                                // recipename: doc['recipename'],
                                quantity: 1, // Default quantity when missing
                                recipename:doc['recipename'], // Default price when missing
                              );
                            }

                            return Recipe(
                              recipeTitle: doc['recipeTitle'],
                              cookingTime: doc['cookingTime'],
                              description: doc['description'],
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
                                        Image.asset(
                                          recipe.image,
                                          width: 80,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 10,height:30),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height:35),
                                            Text(
                                              recipe.recipeTitle,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          Text(
                                              'Price: ${recipe.initialPrice != null ? '\$${recipe.initialPrice.toStringAsFixed(2)}' : recipe.recipename}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color:Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                          Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            _updateQuantity(context, recipe.recipeId, recipe.quantity - 1);
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
                                            _updateQuantity(context, recipe.recipeId, recipe.quantity + 1);
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
                                            _deleteItem(context, recipe.recipeId);
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                     
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(154, 36),
                                            backgroundColor: Color.fromARGB(255, 248, 78, 11),
                                            foregroundColor: Colors.white,
                                            
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => KhaltiPayment( recipePrice: recipe.recipename, recipeTitle: '',),
                                                // OrderConfirmationScreen(
                                                //   recipeTitle: recipe.recipeTitle,
                                                //   recipename: '',
                                                // ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                'Place order',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
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
                      Icons.home_outlined,
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
                            builder: (context) => CartPage(
                                recipeTitle: '', context: context),
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
                          builder: (context) => UserProfileScreen(
                             
                            ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.person_outline,
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
      final CollectionReference cartCollection = firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart');

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
                    setState(() {});
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



