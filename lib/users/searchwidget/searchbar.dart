import 'package:baisnab/data/recipelist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/menue.dart/recipe1.dart';
import '../screens/menue.dart/recipiedetails.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
     final recipeProvider = Provider.of<RecipeProvider>(context);
    final filteredRecipes = recipeProvider.filteredRecipes;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Recipes',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                fillColor: Color.fromARGB(255, 252, 248, 248),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 228, 228, 228), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 238, 233, 233), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.all(16.0),
                hintText: 'Search Here',
                hintStyle: TextStyle(color: Color.fromARGB(255, 186, 184, 184)),
              ),
              onChanged: (query) {
          // Call the filter method when text changes
          recipeProvider.filterRecipes(query);
        },
              controller: _searchController,
            ),
          ),
         Expanded(
        child: Consumer<RecipeProvider>(
          builder: (context, recipeProvider, child) {
            final filteredRecipes = recipeProvider.filteredRecipes;

            return ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(filteredRecipes[index].image),
                  title: Text(filteredRecipes[index].recipeTitle),
                  subtitle: Text(
                    'NRS ${filteredRecipes[index].recipename.toString()}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetPage(
                            recipes: [],
                                
                          recipe: filteredRecipes[index],
                        ),
                      ),
                    );
                  },
                  // You can customize the ListTile to display more recipe information here
                );
              },
            );}
          ),
         )
        ],
      ),
    );
  }
}
