// ignore_for_file: unused_local_variable

import 'dart:convert';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'package:baisnab/screens/cartpage/cart.dart';

import '../../data/recipe1.dart';
import '../cartpage/addfvorite.dart';
import '../profile/profile_screen.dart';
import 'recipedetails.dart';

class Recipe {
  final String recipeId;
  final String recipeTitle;
  final String recipename;
  final String cookingTime;
 
  final String description;
  final String image;

  Recipe({
    required this.recipeId,
    required this.recipeTitle,
    required this.recipename,
    required this.cookingTime,
  
    required this.description,
    required this.image,
  });

  // Convert Recipe to a map for Firestore
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recipeId': recipeId,
      'recipeTitle': recipeTitle,
      'recipename': recipename,
      'cookingTime': cookingTime,
      
      'description': description,
      'image': image,
    };
  }

  // Create Recipe object from Firestore document snapshot
  factory Recipe.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Recipe(
      recipeId: data['recipeID'],
      recipeTitle: data['recipeTitle'],
      recipename: data['recipename'],
      cookingTime: data['cookingTime'],
     
      description: data['description'],
      image: data['image'],
    );
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      recipeId: map['recipeId'] as String,
      recipeTitle: map['recipeTitle'] as String,
      recipename: map['recipename'] as String,
      cookingTime: map['cookingTime'] as String,
     
      description: map['description'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HomePagee extends StatelessWidget {
  const HomePagee({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: Row(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical:
                              15), // Replace `8.0` with your desired margin value
//  GoogleFonts.lato
                      child: Text(
                        "Recipe List",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    Recipe recipe = recipes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // ignore: prefer_const_literals_to_create_immutables
                            builder: (context) => RecipeDetPage(
                              recipes: [],
                              recipe: recipe,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 480,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              shadowColor: Colors.tealAccent,
                              color: const Color(0xFFF4F5FE),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      recipe.image,
                                      fit: BoxFit.cover,
                                      width: 130,
                                      height: 110,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 15),
                                      child: Column(
                                        children: [
                                          Text(
                                            recipe.recipeTitle,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            recipe.recipename,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18,
                                              ),
                                              SizedBox(width: 8.0),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 13),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.favorite,
                                              size: 14.0,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 13),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.share,
                                          size: 14.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 45,
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
                onPressed: () {},
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                  size: 26,
                ),
              ),
             IconButton(
              enableFeedback: false,
              onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritePage(
                          favoriteProducts: [],
                        ),
                      ));},
              icon: const Icon(
                Icons.favorite,
              
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
                              context: context, 
                            ),
                          ));
                },
                icon: const Icon(
                 Icons.shopping_cart,
                  //  color: Colors.black,
                  size:26,
                ),
              ),
             
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(
                        email: '',
                        phoneNumber: '',
                        username: '',
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
      );
}
/////******************************
/////////**********************
///*****************************
///*********************
///********************
/// */ */ */ */ */
/// due to  some small error from the recipe to move into the next page  that make me all code are written in the same page when the error  was solved
/// and we add this to their own page
// ignore_for_file: public_member_api_docs, sort_constructors_first

class RecipeDetPage extends StatelessWidget {
  final Recipe recipe;

   RecipeDetPage({
    Key? key,
    required this.recipe,
    required List<Recipe> recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

   

    return Scaffold(
     
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
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
                    vertical:
                        15), 
// GoogleFonts.lato
                child: Text(
                  "Recipe List",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                recipe.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                'Recipe title: ${recipe.recipeTitle}',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Cooking Time: ${recipe.cookingTime}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              const SizedBox(height: 16),
              Text(
                'Descriptions:${recipe.description}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 50),
                    backgroundColor:
                        Colors.greenAccent, // Set the background color
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddToCartPage(
                                  recipe: recipe,
                                )));
                  },
                  // GoogleFonts.lato
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart, color: Colors.black),
                      Text(
                        'Add to Cartpage',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
//////here is the last code for the add to cart page ********************
///**********************************8
///*********************** */ */

class FirestoreService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('cart');

  Future<List<DocumentSnapshot>> getDocuments() async {
    QuerySnapshot querySnapshot = await _collection.get();
    return querySnapshot.docs;
  }
}

class AddToCartPage extends StatelessWidget {
  final Recipe recipe;

  const AddToCartPage({Key? key, required this.recipe}) : super(key: key);

  Future<void> addToCart(BuildContext context, Recipe recipe) async {
    final FirestoreService _firestoreService = FirestoreService();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String documentId =
        'X3gL3CASwLwTscI6tM19'; // Replace with your desired document ID

    try {
      await firestore.collection('cart').doc(documentId).set(recipe.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe added to cart')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add recipe to cart')),
      );
    }
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
                      "  Cartpage ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        recipe.image,
                        fit: BoxFit.cover,
                        width: 90,
                        height: 80,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            recipe.recipeTitle,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            recipe.recipename,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 50),
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      await addToCart(context, recipe);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => CartPage(
                      //         context: context, 
                      //       ),
                      //     ));
                    },
                    child: Row(
                      children: [
                        Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CartPage extends StatelessWidget {
//   final BuildContext context;

//   CartPage({required this.context});

//   Future<void> deleteFromCart(String recipeTitle) async {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;

//     try {
//       await firestore.collection('cart').doc(recipeTitle).delete();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Recipe deleted from cart')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to delete recipe from cart')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold
//     (
      
//         body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('cart').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }

//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }

//           List<Recipe> cartItems = snapshot.data!.docs.map((doc) {
//             return Recipe(
//               recipeTitle: doc['recipeTitle'],
//               cookingTime: doc['cookingTime'],
//               readingTime: doc['readingTime'],
//               description: doc['description'],
//               image: doc['image'],
//               recipeId: doc['recipeId'],
//               recipename: doc['recipename'],
//             );
//           }).toList();

//           return ListView.builder(
//             itemCount: cartItems.length,
//             itemBuilder: (context, index) {
//               final recipe = cartItems[index];
//               return ListTile(
//              title:Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       height: 50,
//                       width: 30,
//                       child: IconButton(
//                         icon: const Icon(Icons.arrow_back_ios_sharp),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                   ),
                
//                 ],
//               ),
// SizedBox(height: 30,),
//   Row(
//     children: [
//       Image.asset(
//         recipe.image,
//         width: 50,
//         height: 50,
//         fit: BoxFit.cover,
//       ),
//       SizedBox(width: 10), // Add some spacing between the image and text
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(recipe.recipeTitle),
//           Text(recipe.recipename),
//         ],
//       ),
//       SizedBox(width: 30,),
//         IconButton(
//     icon: Icon(Icons.delete),
//     onPressed: () => deleteFromCart(recipe.recipeTitle),
//      .then((_) {
//          // Remove the item from the list
//           cartItems.removeAt(index);
//           }),
//   ),
//     ],
//   ),
 
  
// ]));

//               // return ListTile(
//               //   title: Text(recipe.recipeTitle),
//               //   subtitle: Text(recipe.description),
//               //   trailing: IconButton(
//               //     icon: Icon(Icons.delete),
//               //     onPressed: () => deleteFromCart(recipe.recipeId),
//               //   ),
//               // );
//             },
//           );
//         },
//     ),



///*********************************************************\//
class CartPage extends StatelessWidget {
  final BuildContext context;

  CartPage({required this.context});

  Future<void> deleteFromCart(String recipeTitle) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('cart').doc(recipeTitle).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe deleted from cart',style: TextStyle( backgroundColor: Colors.greenAccent),)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete recipe from cart',style: TextStyle( backgroundColor: Colors.red),)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('cart').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('Your cart is empty.'),
              );
            }

            List<Recipe> cartItems = snapshot.data!.docs.map((doc) {
              return Recipe(
                recipeTitle: doc['recipeTitle'],
                cookingTime: doc['cookingTime'],
               
                description: doc['description'],
                image: doc['image'],
                recipeId: doc['recipeId'],
                recipename: doc['recipename'],
              );
            }).toList();

            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final recipe = cartItems[index];
                return ListTile(
                  title: Column(
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
                                color: Colors.black,
                                icon: const Icon(Icons.arrow_back_ios_sharp),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            recipe.image,
                            width: 90,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(recipe.recipeTitle,style: TextStyle(    
                                fontSize: 17,
                                fontWeight: FontWeight.bold,),),
                              Text(recipe.recipename, style:TextStyle(    
                                fontSize: 16,
                                fontWeight: FontWeight.bold,),),
                            ],
                          ),
                          SizedBox(
                            width: 90,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteFromCart(recipe.recipeTitle)
                                .then((_) {
                              // Remove the item from the list
                              cartItems.removeAt(index);
                            }),
                          ),
                        ],
                      ),
                  
                   SizedBox(
                        height: 70,
                      ),
                  Column(
                     children: [
                       
                      
                        ElevatedButton(
                 style: ElevatedButton.styleFrom(
                       fixedSize: const Size(200, 50),
                         backgroundColor:
                             Colors.greenAccent, // Set the background color
                         foregroundColor: Colors.white, // Set the text color
                       ),
                       onPressed: () {
                         Navigator.push(
                         context,
                          MaterialPageRoute(
                            builder: (context) => const OrderFormPage(
                              cartItems: [],
                            ),
                          ),
                        );
                  },
                  child: Row(
                        children: [
                          Text(
                            'Place my order',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                  ),
                )
                     ],
                   )  ],
                  ),);
              },
            );
          },
        ),
        //***********************8
        //888888888888888
        //888888888888 */
  //    class CartPage extends StatelessWidget {
  // final BuildContext context;
  // final String userId; // User ID
  //  final String documentId =
  //       'X3gL3CASwLwTscI6tM19';
  // CartPage({required this.context, required this.userId});

  // Future<void> deleteFromCart(String recipeTitle) async {
   
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   try {
  //     await firestore
  //         .collection('cart') // Use 'users' collection to store user-specific data
  //         .doc(documentId) // Use user's ID as the document ID
  //         .collection('users') // Use 'cart' collection to store cart items under the user's ID
  //         .doc(userId)
  //         .delete();

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Recipe deleted from cart')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Failed to delete recipe from cart')),
  //     );
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       body: StreamBuilder<QuerySnapshot>(
  //         stream: FirebaseFirestore.instance
  //             .collection('cart') // Use 'users' collection to retrieve user-specific data
  //             .doc( 'X3gL3CASwLwTscI6tM19') // Use user's ID as the document ID
  //             .collection('users') 
  //              // Use 'cart' collection under the user's ID
  //             .snapshots(),
//  builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }

//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return Center(
//                 child: Text('Your cart is empty.'),
//               );
//             }

//             List<Recipe> cartItems = snapshot.data!.docs.map((doc) {
//               return Recipe(
//                 recipeTitle: doc['recipeTitle'],
//                 cookingTime: doc['cookingTime'],
//                 readingTime: doc['readingTime'],
//                 description: doc['description'],
//                 image: doc['image'],
//                 recipeId: doc['recipeId'],
//                 recipename: doc['recipename'],
//               );
//             }).toList();

//             return ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final recipe = cartItems[index];
//                 return ListTile(
//                   title: Column(
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SizedBox(
//                               height: 50,
//                               width: 30,
//                               child: IconButton(
//                                 icon: const Icon(Icons.arrow_back_ios_sharp),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             recipe.image,
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           ),
//                           SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(recipe.recipeTitle),
//                               Text(recipe.recipename),
//                             ],
//                           ),
//                           SizedBox(
//                             width: 30,
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () => deleteFromCart(recipe.recipeTitle)
//                                 .then((_) {
//                               // Remove the item from the list
//                               cartItems.removeAt(index);
//                             }),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//this upper codes end here . here i try to add the recipe that which i add on the name of users that will store  continously in the cart 
//page until users didnot delete it//
       
      bottomNavigationBar: Container(
        height: 45,
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
              onPressed: () {},
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.black,
                size: 26,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
              
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
                              context: context, 
                            ),
                          ));
                },
                icon: const Icon(
                 Icons.shopping_cart,
                  //  color: Colors.black,
                  size:26,
                ),
              ),
         
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.push(
                  context as BuildContext,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(
                      email: '',
                      phoneNumber: '',
                      username: '',
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
     );
  }
}
///////this is the last item***************************
///********************************88
///8******************************
///*********************************
///*************************
///********************
///************ */ */ */ */ */
//  class AddToCartPage extends StatelessWidget {
//   final Recipe recipe;

//   const AddToCartPage({Key? key, required this.recipe}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;

//     // Function to add recipe to Firestore
//     Future<void> addToCart(BuildContext context, Recipe recipe) async {
//       try {
//         await firestore.collection('cart').add(recipe.toMap());
//         // ignore: use_build_context_synchronously
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Recipe added to cart')),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to add recipe to cart')),
//         );
//       }
//     }

//       return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView
//       (
//           padding: const EdgeInsets.all(16),
//           child: Column(children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     height: 50,
//                     width: 30,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back_ios_sharp),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 70,
//                       vertical:
//                           15), // Replace `8.0` with your desired margin value
// // GoogleFonts.lato
//                   child: Text(
//                     "  Cartpage ",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20,),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Image.asset(
//                       recipe.image,
//                       fit: BoxFit.cover,
//                       width: 90,
//                       height: 80,
// // GoogleFonts.latoGoogleFonts.lato
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           recipe.recipeTitle,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 19,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           recipe.recipename,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height:35),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(250, 50),
//                     backgroundColor:
//                         Colors.greenAccent, // Set the background color
//                     foregroundColor: Colors.white, // Set the text color
//                   ),
//                   onPressed: ()async  {
//                        // ignore: unused_local_variable
//                        final FirebaseFirestore firestore = FirebaseFirestore.instance;

//     // Function to add recipe to Firestore

//                 Recipe recipe = Recipe(
//                   recipeTitle: ' recipe.recipeTitle',
//                   cookingTime: 'cookingtime',
//                   readingTime: 'readingtime',
//                   description: '',
//                   image: '', recipeId: 'cart', recipename: 'recipename',
//                 );
//                 await addToCart(context, recipe);

//                   },
//                   child: Row(
//                     children: [
//                       Text(
//                         'Add to Cart',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   // GoogleFonts.lato
//                 ),
//               ],
//             ),
//           ]))
//       )
//     );
//   }
// }

// class CartPage extends StatelessWidget {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   // Function to delete recipe from Firestore
//   Future<void> deleteFromCart(String recipeTitle) async {
//     try {
//       await firestore.collection('cart').doc(recipeTitle).delete();
//       ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//         const SnackBar(content: Text('Recipe deleted from cart')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//         const SnackBar(content: Text('Failed to delete recipe from cart')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//       ),
//        body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('cart').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }

//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }

//           List<Recipe> cartItems = snapshot.data!.docs.map((doc) {
//             return Recipe(
//               recipeTitle: doc['recipeTitle'],
//               cookingTime: doc['cookingTime'],
//               readingTime: doc['readingTime'],
//               description: doc['description'],
//               image: doc['image'], recipeId: '', recipename: doc['recipename'],
//             );
//           }).toList();

//           return ListView.builder(
//             itemCount: cartItems.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(cartItems[index].recipeTitle),
//                 subtitle: Text(cartItems[index].description),
//               );
//             },
//           );
//         },
//       ),
// body: StreamBuilder<QuerySnapshot>(
//   stream: firestore.collection('cart').snapshots(),

//   builder: (context, snapshot) {
//     try {
//       if (snapshot.hasError) {
//         return const Text('Error');
//       }

//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const CircularProgressIndicator();
//       }

//       final List<Recipe> cartRecipes = snapshot.data!.docs
//           .map((doc) => Recipe.fromSnapshot(doc))
//           .toList();

//       return ListView.builder(
//         itemCount: cartRecipes.length,
//         itemBuilder: (context, index) {
//           final recipe = cartRecipes[index];
//           return ListTile(
//             title: Text(recipe.recipeTitle),
//             subtitle: Text(recipe.description),
//             leading: Image.asset(recipe.image),
//           );
//         },
//       );
//     } catch (e) {
//       return const Text('Error');
//     }
//   },
// ),
//     );
//   }
// }

// class AddToCartPage extends StatelessWidget {
//   final Recipe recipe;

//   const AddToCartPage({Key? key, required this.recipe}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView
//       (
//           padding: const EdgeInsets.all(16),
//           child: Column(children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     height: 50,
//                     width: 30,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back_ios_sharp),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 70,
//                       vertical:
//                           15), // Replace `8.0` with your desired margin value
// // GoogleFonts.lato
//                   child: Text(
//                     "  Cartpage ",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20,),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Image.asset(
//                       recipe.image,
//                       fit: BoxFit.cover,
//                       width: 90,
//                       height: 80,
// // GoogleFonts.latoGoogleFonts.lato
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           recipe.recipeTitle,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 19,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           recipe.recipename,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height:35),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(250, 50),
//                     backgroundColor:
//                         Colors.greenAccent, // Set the background color
//                     foregroundColor: Colors.white, // Set the text color
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const OrderFormPage(
//                           cartItems: [],
//                         ),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     children: [
//                       Text(
//                         'Place my order',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   // GoogleFonts.lato
//                 ),
//               ],
//             ),
//           ]))),

//     );
//   }
// }
