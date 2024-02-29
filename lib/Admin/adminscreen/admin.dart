import 'package:baisnab/Admin/adminscreen/addrecipe.dart';
import 'package:baisnab/Admin/adminscreen/edit.dart';
import 'package:baisnab/Admin/adminscreen/editaddedrecipe.dart';
import 'package:baisnab/Admin/adminscreen/orderlist.dart';
import 'package:baisnab/Admin/adminscreen/recipelist.dart';
import 'package:baisnab/Admin/userlist.dart';
import 'package:baisnab/users/craud/login_screen.dart';
import '../../users/short/short.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baisnab/model/model.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            minWidth: constraints.maxWidth,
          ),
          child: IntrinsicHeight(
            child:ListView(
  physics: const BouncingScrollPhysics(),
  scrollDirection: Axis.vertical,
  children: [
              //  Container(
              //   height: MediaQuery.of(context).size.height,
              //   width: double.infinity,
                // child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          horizontal: 50,
                          vertical: 15,
                        ),
                        child: Text(
                          "Admin Page",
                          style: TextStyle(
                            // color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: IconButton(
                                icon: const Icon(
                                  Icons.logout,
                                ),
                                onPressed: () {
                                  logout(context);
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AdminCard(
                            title: 'Edit-Recipe',
                            image:
                                'assets/1200px-SVG-edit_logo.svg.png', // Replace with actual image path
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminEditCartPage(),
                                ),
                              );
                              print('Edit pressed');
                            },
                          ),
                          SizedBox(height: 16),
                          AdminCard(
                            title: ' User List',
                            image:
                                'assets/4791601.png', // Replace with actual image path
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserListScreen(),
                                ),
                              );
                              print('Add User List pressed');
                            },
                          ),
                          SizedBox(height: 16),
                          AdminCard(
                            title: 'Add Recipe',
                            image:
                                'assets/add-1-ico.png', // Replace with actual image path
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddRecipeScreen(),
                                ),
                              );
                              print('Order List pressed');
                            },
                          ),
                          SizedBox(height: 16),
                          AdminCard(
                            title: 'Order List',
                            image:
                                'assets/orders-list-vector-17727433.jpg', // Replace with actual image path
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderListScreen(),
                                ),
                              );
                              print('Order List pressed');
                            },
                          ),
                          AdminCard(
                            title: 'View Recipe-list',
                            image:
                                'assets/restaurant.jpg', // Replace with actual image path
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminRecipeList(),
                                ),
                              );
                              print('Add User List pressed');
                            },
                          ),
                          AdminCard(
                            title: 'View Recipe-list',
                            image:
                                'assets/45.jpg', // Replace with actual image path
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminEditaddedPage(),
                                ),
                              );
                              print('Add User List pressed');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
            //   ),
            // ]),
          ),
        );
      },
    )));
  }
}

// class RecipeList extends StatefulWidget {
//   final List<Recipe> recipes;

//   const RecipeList({
//     Key? key,
//     required this.recipes,
//   }) : super(key: key);

//   @override
//   _RecipeListState createState() => _RecipeListState();
// }

// class _RecipeListState extends State<RecipeList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: widget.recipes.length,
//       itemBuilder: (context, index) {
//         var recipe = widget.recipes[index];

//         return ListTile(
//           title: Text(recipe.recipeTitle),
//           subtitle: Text(recipe.description),
//           // trailing: Text('\$${recipe.price.toString()}'),
//           onTap: () {
//             // Handle recipe selection (edit, delete, etc.)
//             _showRecipeOptionsDialog(context, index);
//           },
//         );
//       },
//     );
//   }

//   _showRecipeOptionsDialog(BuildContext context, int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Recipe Options'),
//           content: Column(
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   // Edit recipe
//                   Navigator.pop(context);
//                   _editRecipe(context, index);
//                 },
//                 child: Text('Edit Recipe'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Delete recipe
//                   Navigator.pop(context);
//                   _deleteRecipe(index);
//                 },
//                 child: Text('Delete Recipe'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   _editRecipe(BuildContext context, int index) {
//     // Implement recipe editing logic
//     // You may need to create another screen for editing
//     // and pass the selected recipe to that screen
//   }

//   _deleteRecipe(int index) {
//     setState(() {
//       widget.recipes.removeAt(index);
//     });
//   }
// }
