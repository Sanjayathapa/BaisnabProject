import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminEditCartPage extends StatefulWidget {
  @override
  _AdminEditCartPageState createState() => _AdminEditCartPageState();
}

class _AdminEditCartPageState extends State<AdminEditCartPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController cookingTimeController = TextEditingController();

  // Initialize selectedRecipeId with a default value
  late String selectedRecipeId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Recipe'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No recipes on the list.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final cartItem = snapshot.data!.docs[index];
              final recipeId = cartItem.id;

              return ListTile(
                title: Card(
                  child: InkWell(
                    onTap: () {
                      // Set the selected recipe ID when clicked
                      setState(() {
                        selectedRecipeId = recipeId;
                        // Set initial values for controllers based on the selected recipe
                        titleController.text = cartItem['recipeTitle'];
                        descriptionController.text = cartItem['description'];
                        priceController.text = cartItem['recipename'].toString();
                        quantityController.text = cartItem['quantity'].toString();
                        cookingTimeController.text = cartItem['cookingTime'].toString();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(cartItem['recipeTitle']),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: selectedRecipeId.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                // Open the form to edit the selected recipe
                _showEditForm();
              },
              child: Icon(Icons.edit),
            )
          : null,
    );
  }

  // Function to show the edit form
  void _showEditForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Recipe'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Recipe Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a recipe title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a quantity';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cookingTimeController,
                    decoration: InputDecoration(labelText: 'Cooking Time'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter cooking time';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Validate the form
                if (_formKey.currentState!.validate()) {
                  // Get values from controllers
                  String updatedTitle = titleController.text;
                  String updatedDescription = descriptionController.text;
                  double updatedPrice = double.parse(priceController.text);
                  int updatedQuantity = int.parse(quantityController.text);

                  // Get cooking time directly as String
                  String updatedCookingTime = cookingTimeController.text;

                  // Update the recipe in the cart with the new details
                  _updateCartItem(
                    context,
                    selectedRecipeId,
                    updatedTitle,
                    updatedDescription,
                    updatedPrice,
                    updatedQuantity,
                    updatedCookingTime,
                  );

                  // Close the dialog
                  Navigator.pop(context);
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateCartItem(
  BuildContext context,
  String recipeId,
  String updatedTitle,
  String updatedDescription,
  double updatedPrice,
  int updatedQuantity,
  String updatedCookingTime, // Change the type to String
) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference cartCollection = firestore.collection('cart');

  // Update the recipe in the cart with the new details
  await cartCollection.doc(recipeId).update({
    'recipeTitle': updatedTitle,
    'description': updatedDescription,
    'recipename': updatedPrice,
    'quantity': updatedQuantity,
    'cookingTime': updatedCookingTime, // Assign the value directly
  });

  // Display a message or perform other actions after updating
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Recipe is updated successfully!'),
  ));
}
}
