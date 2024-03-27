import 'dart:io';
import 'package:baisnab/Admin/adminscreen/admin.dart';
import 'package:baisnab/Admin/adminscreen/recipelist.dart';
import 'package:baisnab/Admin/adminscreen/userlist.dart';
import 'package:baisnab/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

String _imageUrl = '';

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController indexController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cookingTimeController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientController = TextEditingController();

  String _imageUrl = '';
  Future<void> _pickImage() async {
    print('Attempting to pick image...');

    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    print('File picked: $pickedFile');

    if (pickedFile == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(pickedFile.path ?? ''));
      String imageUrl = await referenceImageToUpload.getDownloadURL();

      setState(() {
        _imageUrl = imageUrl;
      });

      print('Image uploaded successfully. URL: $_imageUrl');
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text('Recipe List'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminRecipeList(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('User List'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserListScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Add Recipe'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddRecipeScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Admin DashBoard'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminDashboard(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            // physics: const BouncingScrollPhysics(),

            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                      "Add Recipe List ",
                      style: TextStyle(
                        // color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Recipe Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (value.length < 6) {
                            return 'Too short';
                          }
                          if (RegExp(r'\d').hasMatch(value)) {
                            return 'recipe should not contain numbers';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Recipe Price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: indexController,
                        decoration: InputDecoration(
                          labelText:
                              'Index to put recipe /n in their main recipe related item',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Quantity is required';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Quantity should contain only numbers';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: cookingTimeController,
                        decoration: InputDecoration(
                          labelText: 'Cooking Time (mins)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _buildImagePicker(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller:
                            ingredientController, // TextEditingController for ingredient field
                        decoration: InputDecoration(
                          labelText: 'Ingredient',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                        child: ElevatedButton(
                      onPressed: () {
                        _addRecipe();
                      },
                      child: Text('Add Recipe'),
                    )),
                    SizedBox(height: 20)
                  ],
                ),
              ]),
            ),
          ),
        ));
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _imageUrl.isNotEmpty // Check if _imageUrl is not empty
            ? _buildPickedImage() // If image is picked, display it
            : _buildDottedBorder(), // If not, show the dotted border
        TextButton(
          onPressed: () {
            _pickImage();
          },
          child: Text('Choose an image'),
        ),
      ],
    );
  }

  Widget _buildPickedImage() {
    return Image.network(
      _imageUrl,
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    );
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
          ),
        ),
      ),
    );
  }

  Future<void> _addRecipe() async {
    String recipeTitle = titleController.text.trim();
  String recipeName = nameController.text.trim();
  int index = int.tryParse(indexController.text) ?? 0;
  int cookingTime = int.tryParse(cookingTimeController.text) ?? 0;
  String description = descriptionController.text.trim();
  String ingredients = ingredientController.text.trim(); // Get ingredients

  if (recipeTitle.isNotEmpty &&
      recipeName.isNotEmpty &&
      cookingTime > 0 &&
      index >= 0 &&
      index <= 10 &&
      _imageUrl.isNotEmpty &&
      description.isNotEmpty &&
      ingredients.isNotEmpty) { // Ensure ingredients are not empty
    double? recipePrice = double.tryParse(recipeName);
    Recipe recipe = Recipe(
      recipeId: DateTime.now().millisecondsSinceEpoch.toString(),
      recipeTitle: recipeTitle,
      recipename: recipePrice,
      index: 0,
      cookingTime: cookingTime.toString(),
      image: _imageUrl,
      description: description,
      rating: 0,
      ingredients: ingredients.split(','), // Split ingredients string into a list
    );

    // Call the function to add the recipe to Firestore
    await addRecipeToFirestore(recipe);

    // Clear controllers after adding the recipe
    quantityController.clear();
    titleController.clear();
    indexController.clear();
    nameController.clear();
    cookingTimeController.clear();
    descriptionController.clear();
    ingredientController.clear();

      // Show a message or navigate to another screen after adding the recipe
      // Close the add recipe screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminDashboard(),
        ),
      );
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
          firestore.collection('added');

      await recipesCollection.doc(recipe.recipeTitle).set({
        'recipeTitle': recipe.recipeTitle,
        'recipename': recipe.recipename,
        'index': recipe.index,
        'cookingTime': recipe.cookingTime,
        'image': _imageUrl,
        'quantity': recipe.quantity,
        'description': recipe.description,

      });

      print('Recipe added to Firestore successfully!');
    } catch (e) {
      print('Failed to add the recipe to Firestore: $e');
    }
  }
}
