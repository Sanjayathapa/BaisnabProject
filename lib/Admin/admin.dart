import 'package:baisnab/Admin/recipelist.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baisnab/model/model.dart';




class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print("Signed in: ${userCredential.user!.email}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminPanel()),
      );
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      // Handle login errors here
      // You can show an alert dialog or display an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signIn,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recipes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            RecipeList(recipes: [],),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>AdminRecipeList(),
          ));
          //Homee()
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class RecipeList extends StatefulWidget {
  final List<Recipe> recipes;

  const RecipeList({
    Key? key,
    required this.recipes,
  }) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.recipes.length,
      itemBuilder: (context, index) {
        var recipe = widget.recipes[index];

        return ListTile(
          title: Text(recipe.recipeTitle),
          subtitle: Text(recipe.description),
          // trailing: Text('\$${recipe.price.toString()}'),
          onTap: () {
            // Handle recipe selection (edit, delete, etc.)
            _showRecipeOptionsDialog(context, index);
          },
        );
      },
    );
  }

  _showRecipeOptionsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recipe Options'),
          content: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Edit recipe
                  Navigator.pop(context);
                  _editRecipe(context, index);
                },
                child: Text('Edit Recipe'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Delete recipe
                  Navigator.pop(context);
                  _deleteRecipe(index);
                },
                child: Text('Delete Recipe'),
              ),
            ],
          ),
        );
      },
    );
  }

  _editRecipe(BuildContext context, int index) {
    // Implement recipe editing logic
    // You may need to create another screen for editing
    // and pass the selected recipe to that screen
  }

  _deleteRecipe(int index) {
    setState(() {
      widget.recipes.removeAt(index);
    });
  }
}

// class AddRecipeScreen extends StatelessWidget {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Recipe'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//             TextField(
//               controller: _priceController,
//               decoration: InputDecoration(labelText: 'Price'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _addRecipe(context);
//               },
//               child: Text('Add Recipe'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _addRecipe(BuildContext context) {
//     String name = _nameController.text;
//     String description = _descriptionController.text;
//     double price = double.tryParse(_priceController.text) ?? 0.0;

//     if (name.isNotEmpty && description.isNotEmpty) {
//       setState(() {
//         recipes.add(Recipe(   recipeId: '', recipename: , recipeTitle: '', rating: '', description: '', image: '', cookingTime: ''));
//       });
//       Navigator.pop(context); // Close the add recipe screen
//     } else {
//       // Show an error message if fields are empty
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Please fill in all fields.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
  
//   void setState(Null Function() param0) {}
// }
