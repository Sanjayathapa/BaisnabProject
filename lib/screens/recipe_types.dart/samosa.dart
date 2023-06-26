import 'dart:convert';

import 'package:baisnab/screens/recipe_types.dart/dosa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/recipe1.dart';
import '../cartpage/addfvorite.dart';
import '../cartpage/cart.dart';
import '../menue.dart/recipe1.dart';
import '../menue.dart/recipedetails.dart';
import '../profile/profile_screen.dart';

class FoodIte {
  final String recipeId;
  final String recipeTitle;
  final String recipename;
  final String cookingTime;
  final String readingTime;
  final String description;
  final String image;

  FoodIte({
    required this.recipeId,
    required this.recipeTitle,
    required this.recipename,
    required this.cookingTime,
    required this.readingTime,
    required this.description,
    required this.image,
  });
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recipeId': recipeId,
      'recipeTitle': recipeTitle,
      'recipename': recipename,
      'cookingTime': cookingTime,
      'readingTime': readingTime,
      'description': description,
      'image': image,
    };
  }

  // Create Recipe object from Firestore document snapshot
  factory FoodIte.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return FoodIte(
      recipeId: data['recipeID'],
      recipeTitle: data['recipeTitle'],
      recipename: data['recipename'],
      cookingTime: data['cookingTime'],
      readingTime: data['readingTime'],
      description: data['description'],
      image: data['image'],
    );
  }

  factory FoodIte.fromMap(Map<String, dynamic> map) {
    return FoodIte(
      recipeId: map['recipeId'] as String,
      recipeTitle: map['recipeTitle'] as String,
      recipename: map['recipename'] as String,
      cookingTime: map['cookingTime'] as String,
      readingTime: map['readingTime'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodIte.fromJson(String source) =>
      FoodIte.fromMap(json.decode(source) as Map<String, dynamic>);
}


class SamosaPage extends StatelessWidget {
  SamosaPage({super.key});

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
                  itemCount: food.length,
        itemBuilder: (context, index) {
          final foodIte = food[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // ignore: prefer_const_literals_to_create_immutables
                            builder: (context) => RecipeDetPage(recipes: [], food: foodIte, 
                              
                              
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
                                      foodIte.image,
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
                                            foodIte.recipeTitle,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            foodIte.recipename,
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
class RecipeDetPage extends StatelessWidget {
  final FoodIte food;

   RecipeDetPage({
    Key? key,
    required this.food,
    required List<FoodIte> recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Function to add recipe to Firestore
    // Future<void> addToCart(BuildContext context, Recipe recipe) async {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   try {
//     await firestore
//         .collection('cart') // Specify the collection ID (e.g., 'cart')
//         .doc(

// '') // Let Firestore automatically generate the document ID
//         .set(recipe.toMap());

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Recipe added to cart')),
//     );
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Failed to add recipe to cart')),
//     );
//   }
// }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(recipe.recipeTitle),
      // ),
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
                food.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                'Recipe title: ${ food.recipeTitle}',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Cooking Time: ${ food.cookingTime}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Reading Time: ${ food.readingTime}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Descriptions:${ food.description}',
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
                                  food: food,
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
  final FoodIte food;

  const AddToCartPage({Key? key, required this.food}) : super(key: key);

  Future<void> addToCart(BuildContext context, FoodIte recipe) async {
    final FirestoreService _firestoreService = FirestoreService();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String documentId =
        'X3gL3CASwLwTscI6tM19'; // Replace with your desired document ID

    try {
      await firestore.collection('cart').doc(documentId).set(food.toMap());

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
                         food.image,
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
                             food.recipeTitle,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                             food.recipename,
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
                      await addToCart(context,  food);
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



///*********************************************************\//
class CartPage extends StatelessWidget {
  final BuildContext context;

  CartPage({required this.context});

  Future<void> deleteFromCart(String recipeTitle) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('cart').doc(recipeTitle).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe deleted from cart',)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete recipe from cart')),
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

            List<FoodIte> cartItems = snapshot.data!.docs.map((doc) {
              return  FoodIte(
                recipeTitle: doc['recipeTitle'],
                cookingTime: doc['cookingTime'],
                readingTime: doc['readingTime'],
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
                var recipeTitle;
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
                              Text( food[index].recipeTitle,style: TextStyle(    
                                fontSize: 17,
                                fontWeight: FontWeight.bold,),),
                              Text(food[index].recipename, style:TextStyle(    
                                fontSize: 16,
                                fontWeight: FontWeight.bold,),),
                            ],
                          ),
                          SizedBox(
                            width: 90,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteFromCart(food[index].recipeTitle)
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
