import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_recipe');
              },
              child: Text('Add Recipe'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/edit_recipes');
              },
              child: Text('Edit Recipes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/delete_recipes');
              },
              child: Text('Delete Recipes'),
            ),
          ],
        ),
      ),
    );
  }
}
