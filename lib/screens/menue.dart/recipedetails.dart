// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';

// import '../cartpage/cart.dart';

// import '../profile/profile_screen.dart';
// import 'recipe1.dart';

// class RecipeDetPage extends StatelessWidget {
//   final Recipe recipe;

//   const RecipeDetPage({
//     Key? key,
//     required this.recipe,
//     required List<Recipe> recipes,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(recipe.recipeTitle),
//       // ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   height: 50,
//                   width: 30,
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back_ios_sharp),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 70,
//                     vertical:
//                         15), // Replace `8.0` with your desired margin value
// // GoogleFonts.lato
//                 child: Text(
//                   "Recipe List",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.asset(
//                 recipe.image,
//                 width: double.infinity,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Recipe title: ${recipe.recipeTitle}',
//                 style: const TextStyle(
//                   fontSize: 23,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Cooking Time: ${recipe.cookingTime}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Reading Time: ${recipe.readingTime}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Descriptions:${recipe.description}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const SizedBox(height: 16.0),

//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(250, 50),
//                     backgroundColor:
//                         Colors.greenAccent, // Set the background color
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AddToCartPage(recipe: recipe),
//                       ),
//                     );
//                   },
//                   // GoogleFonts.lato
//                   child: Row(
//                     children: [
//                       const Icon(Icons.shopping_cart, color: Colors.black),
//                       Text(
//                         'Add to Cartpage',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//               // Column(
//               //   crossAxisAlignment: CrossAxisAlignment.start,
//               //   children: List.generate(
//               //     recipe.ingredients.length,
//               //     (index) => Text(
//               //       '- ${recipe.ingredients[index]}',
//               //       style: TextStyle(fontSize: 16),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
// }
// // class Recipe {
// //   String recipeTitle;
// //   String recipename;
// //   String cookingTime;
// //   String readingTime;
// //   String image;
// //   String description;
// //   int quantity;

// //   Recipe({
// //     required this.recipeTitle,
// //     required this.recipename,
// //     required this.cookingTime,
// //     required this.readingTime,
// //     required this.image,
// //     required this.description,
// //     this.quantity = 1,
// //   });
// // }

// class AddToCartPage extends StatelessWidget {
//   final Recipe recipe;

//   const AddToCartPage({Key? key, required this.recipe}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;

//     // Function to add recipe to Firestore
//     Future<void> addToCart() async {
//       try {
//         await firestore.collection('cart').add(recipe.toMap());
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Recipe added to cart')),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to add recipe to cart')),
//         );
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add to Cart'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: addToCart,
//           child: const Text('Add to Cart'),
//         ),
//       ),
//     );
//   }
// }

// class Recipe {
//   final String recipeTitle;
//   final String recipename;
//   final String cookingTime;
//   final String readingTime;
//   final String description;
//   final String image;

//   Recipe({
//     required this.recipeTitle,
//     required this.recipename,
//     required this.cookingTime,
//     required this.readingTime,
//     required this.description,
//     required this.image,
//   });

//   // Convert Recipe to a map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'recipeTitle': recipeTitle,
//       'cookingTime': cookingTime,
//       'readingTime': readingTime,
//       'description': description,
//       'image': image,
//     };
//   }

//   // Create Recipe object from Firestore document snapshot
//   factory Recipe.fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     return Recipe(
//       recipeTitle: data['recipeTitle'],
//       recipename: data['recipename'],
//       cookingTime: data['cookingTime'],
//       readingTime: data['readingTime'],
//       description: data['description'],
//       image: data['image'],
//     );
//   }
// }

// class CartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: firestore.collection('cart').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Text('Error');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }

//           final List<Recipe> cartRecipes = snapshot.data!.docs
//               .map((doc) => Recipe.fromSnapshot(doc))
//               .toList();

//           return ListView.builder(
//             itemCount: cartRecipes.length,
//             itemBuilder: (context, index) {
//               final recipe = cartRecipes[index];
//               return ListTile(
//                 title: Text(recipe.recipeTitle),
//                 subtitle: Text(recipe.description),
//                 leading: Image.asset(recipe.image),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // class AddToCartPage extends StatelessWidget {
// //   final Recipe recipe;

// //   const AddToCartPage({Key? key, required this.recipe}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: SingleChildScrollView
// //       (
// //           padding: const EdgeInsets.all(16),
// //           child: Column(children: [
// //             Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisAlignment: MainAxisAlignment.start,
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: SizedBox(
// //                     height: 50,
// //                     width: 30,
// //                     child: IconButton(
// //                       icon: const Icon(Icons.arrow_back_ios_sharp),
// //                       onPressed: () {
// //                         Navigator.pop(context);
// //                       },
// //                     ),
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(
// //                       horizontal: 70,
// //                       vertical:
// //                           15), // Replace `8.0` with your desired margin value
// // // GoogleFonts.lato
// //                   child: Text(
// //                     "  Cartpage ",
// //                     style: TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 22,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 20,),
// //             Column(
// //               children: [
// //                 Row(
// //                   children: [
// //                     Image.asset(
// //                       recipe.image,
// //                       fit: BoxFit.cover,
// //                       width: 90,
// //                       height: 80,
// // // GoogleFonts.latoGoogleFonts.lato
// //                     ),
// //                     const SizedBox(
// //                       width: 20,
// //                     ),
// //                     Column(
// //                       children: [
// //                         Text(
// //                           recipe.recipeTitle,
// //                           style: TextStyle(
// //                             color: Colors.black,
// //                             fontSize: 19,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         Text(
// //                           recipe.recipename,
// //                           style: TextStyle(
// //                             color: Colors.black,
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height:35),
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     fixedSize: const Size(250, 50),
// //                     backgroundColor:
// //                         Colors.greenAccent, // Set the background color
// //                     foregroundColor: Colors.white, // Set the text color
// //                   ),
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => const OrderFormPage(
// //                           cartItems: [],
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                   child: Row(
// //                     children: [
// //                       Text(
// //                         'Place my order',
// //                         style: TextStyle(
// //                           color: Colors.black,
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   // GoogleFonts.lato
// //                 ),
// //               ],
// //             ),
// //           ]))),
// //       bottomNavigationBar: Container(
// //         height: 45,
// //         decoration: const BoxDecoration(
// //           color: Color(0xFFFAF5E1),
// //           borderRadius: BorderRadius.only(
// //             topLeft: Radius.circular(20),
// //             topRight: Radius.circular(20),
// //           ),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceAround,
// //           children: [
// //             IconButton(
// //               enableFeedback: false,
// //               onPressed: () {},
// //               icon: const Icon(
// //                 Icons.home_outlined,
// //                 color: Colors.black,
// //                 size: 26,
// //               ),
// //             ),
// //             IconButton(
// //               enableFeedback: false,
// //               onPressed: () {},
// //               icon: const Icon(
// //                 Icons.work_outline_outlined,
// //                 color: Colors.black,
// //                 size: 26,
// //               ),
// //             ),
// //             IconButton(
// //               enableFeedback: false,
// //               onPressed: () {},
// //               icon: const Icon(
// //                 Icons.widgets_outlined,
// //                 color: Colors.black,
// //                 size: 26,
// //               ),
// //             ),
// //             IconButton(
// //               enableFeedback: false,
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => const ProfileScreen(
// //                       email: '',
// //                       phoneNumber: '',
// //                       username: '',
// //                     ),
// //                   ),
// //                 );
// //               },
// //               icon: const Icon(
// //                 Icons.person_outline,
// //                 color: Colors.black,
// //                 size: 26,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
