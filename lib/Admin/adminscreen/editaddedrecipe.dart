import 'package:baisnab/Admin/adminscreen/addrecipe.dart';
import 'package:baisnab/Admin/adminscreen/admin.dart';
import 'package:baisnab/Admin/adminscreen/edit.dart';
import 'package:baisnab/Admin/adminscreen/orderlist.dart';
import 'package:baisnab/Admin/adminscreen/recipelist.dart';
import 'package:baisnab/Admin/adminscreen/userlist.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminEditaddedPage extends StatefulWidget {
  @override
  _AdminEditaddedPageState createState() => _AdminEditaddedPageState();
}

class _AdminEditaddedPageState extends State<AdminEditaddedPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController cookingTimeController = TextEditingController();

  late String selectedRecipeId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Added Recipe',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 251, 242, 202),
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: 50),
              ListTile(
                title: Text(
                  ' New Recipe List',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
                title: Text(
                  'User List',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
                title: Text(
                  'Order List',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderListScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Add Recipe',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
                title: Text(
                  'Edit Recipe',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminEditCartPage(),
                    ),
                  );  },
              ),
              ListTile(
                title: Text(
                  'Admin DashBoard',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('added').snapshots(),
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

              return Container(
                  child: ListTile(
                title: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  shadowColor: Color.fromARGB(255, 196, 243, 196),
                  color: Color.fromARGB(255, 195, 254, 58),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedRecipeId = recipeId;

                        titleController.text = cartItem['recipeTitle'];
                        descriptionController.text = cartItem['description'];
                        priceController.text =
                            cartItem['recipename'].toString();
                        quantityController.text =
                            cartItem['quantity'].toString();
                        cookingTimeController.text =
                            cartItem['cookingTime'].toString();
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            cartItem['recipeTitle'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 13),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              _deleteItem(context, recipeId);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
            },
          );
        },
      ),
      floatingActionButton: selectedRecipeId.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                _showEditForm();
              },
              child: Icon(Icons.edit),
            )
          : null,
    );
  }

  void _showEditForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           backgroundColor: Color.fromARGB(255, 250, 140, 96),
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
                if (_formKey.currentState!.validate()) {
                  String updatedTitle = titleController.text;
                  String updatedDescription = descriptionController.text;
                  double updatedPrice = double.parse(priceController.text);
                  int updatedQuantity = int.parse(quantityController.text);

                  String updatedCookingTime = cookingTimeController.text;

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
    final CollectionReference cartCollection = firestore.collection('added');

    // Update the recipe in the cart with the new details
    await cartCollection.doc(recipeId).update({
      'recipeTitle': updatedTitle,
      'description': updatedDescription,
      'recipename': updatedPrice,
      'quantity': updatedQuantity,
      'cookingTime': updatedCookingTime, // Assign the value directly
    });
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Recipe is updated successfully!'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

Future<void> _deleteItem(BuildContext context, String recipeId) async {
  try {
    await FirebaseFirestore.instance.collection('added').doc(recipeId).delete();

    // Display a message or perform other actions after deleting
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Recipe is deleted successfully!'),
    ));
  } catch (e) {
    print('Error deleting recipe: $e');
  }
}
