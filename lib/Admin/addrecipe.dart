import 'dart:io';

import 'package:baisnab/Admin/orderlist.dart';
import 'package:baisnab/Admin/recipelist.dart';
import 'package:baisnab/Admin/userlist.dart';
import 'package:baisnab/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cookingTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String _imageUrl = ''; // Change to String

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Recipe',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text('Order List'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderListScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('User List'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserListScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('Add Recipe'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminRecipeList()),
                  );
                  // Handle Add Recipe tap
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Recipe Title'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Recipe Name'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: cookingTimeController,
                decoration: InputDecoration(labelText: 'Cooking Time (mins)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              _buildImagePicker(),
              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              SizedBox(height: 16),
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  _addRecipe();
                },
                child: Text('Add Recipe'),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _imageUrl.isEmpty
            ? _buildDottedBorder()
            : Image.network(
                _imageUrl, // Use _imageUrl instead of _pickedImage
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
        TextButton(
          onPressed: () {
            _pickImage();
          },
          child: Text('Choose an image'),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageUrl = image.path; // Change to path for Web
      });
    } else {
      print('No image has been picked');
    }
  }

  Widget _buildDottedBorder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 100,
        child: Center(
            child: DottedBorder(
          dashPattern: const [6.7],
          borderType: BorderType.RRect,
          color: Colors.blue,
          radius: const Radius.circular(12),
          child: Center(
            child: Icon(
              Icons.image_outlined,
              color: Colors.blue,
              size: 50,
            ),
          ),
        )),
      ),
    );
  }

  Future<void> _addRecipe() async {
    String recipeTitle = titleController.text.trim();
    String recipeName = nameController.text.trim();
    int cookingTime = int.tryParse(cookingTimeController.text) ?? 0;
    String description = descriptionController.text.trim();

    if (recipeTitle.isNotEmpty &&
        recipeName.isNotEmpty &&
        cookingTime > 0 &&
        _imageUrl.isNotEmpty &&
        description.isNotEmpty) {
      // Create a Recipe object
      Recipe recipe = Recipe(
        recipeId: DateTime.now().millisecondsSinceEpoch.toString(),
        recipeTitle: recipeTitle,
        recipename: 0,
        cookingTime: cookingTime.toString(),
        image: _imageUrl,
        description: description,
        rating: 0,
      );

      // Call the function to add the recipe to Firestore
      await addRecipeToFirestore(recipe);

      // Show a message or navigate to another screen after adding the recipe
      Navigator.pop(context); // Close the add recipe screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recipe added successfully!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
    }
  }

  Future<void> addRecipeToFirestore(Recipe recipe) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference recipesCollection =
          firestore.collection('cart');

      await recipesCollection.doc(recipe.recipeId).set({
        'recipeTitle': recipe.recipeTitle,
        'recipename': recipe.recipename,
        'cookingTime': recipe.cookingTime,
        'image': recipe.image,
        'description': recipe.description,
      });

      print('Recipe added to Firestore successfully!');
    } catch (e) {
      print('Failed to add the recipe to Firestore: $e');
    }
  }
}
