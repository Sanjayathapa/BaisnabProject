import 'package:baisnab/googlemap/googlemap.dart';
import 'package:baisnab/users/profile/profile_screen.dart';
import 'package:baisnab/users/screens/cartpage/addfvorite.dart';
import 'package:baisnab/users/screens/home_screen.dart';
import '../notificatiom/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../model/model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baisnab/users/screens/cartpage/cartpage.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Import the rating bar package

DateTime scheduleTime = DateTime.now();

class AddToCartPage extends StatefulWidget {
  final Recipe recipe;

  AddToCartPage({Key? key, required this.recipe}) : super(key: key);

  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  double userRating = 0;
  int quantity = 1;
  TextEditingController quantityController = TextEditingController();

  
  void updatePrice(String value) {
    setState(() {
      quantity = int.tryParse(value) ?? 1;
    });
  }

  Future<void> showCustomDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recipe Added'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addToCart(
      BuildContext context, Recipe recipe, int quantity) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;

      if (user != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final CollectionReference cartCollection =
            firestore.collection('users').doc(user.uid).collection('cart');

        // Check if a recipe with the same recipeId already exists
        final QuerySnapshot existingRecipes = await cartCollection
            .where('recipeId', isEqualTo: recipe.recipeId)
            .get();

        if (existingRecipes.docs.isEmpty) {
          String image;

          if (recipe.image != null && recipe.image.startsWith('https://')) {
            // Image is a network image
            image = recipe.image;
          } else if (recipe.image != null &&
              recipe.image.startsWith('assets/')) {
            // Image is from assets
            image = 'asset'; // Placeholder or identifier for assets image
          } else {
            // Default image or placeholder
            image = 'default'; // Placeholder or identifier for default image
          }

          // Calculate price based on quantity
          final double price = (recipe.recipename ?? 0.0) * quantity;

          final Map<String, dynamic> recipeMap = {
            'recipeId': recipe.recipeId,
            'recipeTitle': recipe.recipeTitle,
            'recipename': recipe.recipename,
            'cookingTime': recipe.cookingTime,
            'image': recipe.image,
            'index': recipe.index,
            'description': recipe.description,
            'rating': userRating, // Include user's rating in the cart item
            'quantity': quantity, // Include quantity in the cart item
            'price': price,
            'ingredients': recipe.ingredients,
          };

          // Check if the quantity exceeds 20
          if (quantity <= 20) {
            // Add the recipe to the cart collection
            await cartCollection.add(recipeMap);
            debugPrint('Notification Scheduled for $scheduleTime');
            NotificationService().showNotification(
              title: 'Congratulations! Your order has been added to the cart',
              body: '${widget.recipe.recipeTitle} \n on $scheduleTime',
            );

            // Show a success message (you can replace this with a Snackbar or Dialog)
            showCustomDialog('Recipe is added to Cart Page');
          } else {
            // Show message when quantity exceeds 20
            showCustomDialog(
                'Unable to add more items. Quantity limit reached (20)');
          }
        } else {
          showCustomDialog('Recipe is already in Cart Page');
        }
      }
    } catch (e) {
      print(e.toString());
      print('Failed to add the recipe to the cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final recipeProvider = Provider.of<RecipeProvider>(context);

    Recipe recipe;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                        horizontal: 25, vertical: 20),
                    child: Text(
                      "Recipe to add on the cart page",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        width: 480,
                        child: Card(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              ClipOval(
                                child: buildRecipeImag(widget.recipe),
                                //  Image.asset(
                                //   widget.recipe.image,
                                //   width: 200,
                                //   height: 160,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                child: Text(
                                  'RecipeName: ${widget.recipe.recipeTitle}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Price:  NRS ${widget.recipe.recipename?.toStringAsFixed(2) ?? "0.00"}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  'Rate this product that you like according to your experience',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 93, 248, 16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              RatingBar.builder(
                                initialRating: userRating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                onRatingUpdate: (rating) {
                                  // Update the userRating variable when the user changes the rating
                                  setState(() {
                                    userRating = rating;
                                  });
                                },
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          Text('Quantity:', style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),),
                  SizedBox(width: 10),
                 Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                     
                       width:50,
                      //  height:45,
                      child: TextFormField(
                         maxLines: 1, // Ensures the TextFormField is single line
   
                        keyboardType: TextInputType.number,
                        controller: quantityController,
                        decoration: InputDecoration(
                        
                          hintText: '1',
                        ),
                        onChanged: updatePrice,
                      ),
                    ),
                 )
                                        ],
                    ),
                    SizedBox(height:20),
                    ElevatedButton(
                      onPressed: () {
                  if (quantity <= 20) {
                    addToCart(context, widget.recipe, quantity);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Unable to add more items. Maximum quantity reached (20)'),
                      ),
                    );
                  }
                },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(140, 47),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Color.fromARGB(255, 248, 78, 11),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        'Add to Cart',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    // RatingBar widget for user rating
                  ],
                ),
              ),
            ],
          ),
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
    );
  }
}

Widget buildRecipeImg(Recipe recipe) {
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
      width: 200,
      height: 160,
    );
  } else {
    return Image.asset(
      recipe.image, // Replace with your default image path
      fit: BoxFit.cover,
      width: 200,
      height: 160,
    );
  }
}
