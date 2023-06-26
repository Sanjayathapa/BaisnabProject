
// class searchItem {
//   final String title;

//   searchItem({
//     required this.title,
//   });
// }

// class searchItemPager {
//   int pageIndex = 0;
//   final int pageSize;

//   searchItemPager({
//     this.pageSize = 20,
//   });

//   List<searchItem> nextBatch() {
//     List<searchItem> batch = [];

//     for (int i = 0; i < pageSize; i++) {
//       batch.add(searchItem(title: 'Item ${pageIndex * pageSize + i}'));
//     }

//     pageIndex += 1;

//     return batch;
//   }
// }
//  import '../data/recipe1.dart';
// import '../screens/menue.dart/recipe1.dart';


// class RecipePager {
//   int pageIndex = 0;
//   final int pageSize;

//   RecipePager({
//     this.pageSize = 20,
//   });

//   List<Recipe> nextBatch() {
//     List<Recipe> batch = [];

//     for (int i = 0; i < pageSize; i++) {
//       int recipeIndex = pageIndex * pageSize + i;
//       if (recipeIndex >= recipes.length) break; // Stop if reached the end of the recipe list
//       batch.add(recipes[recipeIndex]);
//     }

//     pageIndex += 1;

//     return batch;
//   }
// }
class RecipePager {
  int pageIndex = 0;
  final int pageSize;
  final List<List<dynamic>> searchLists;

  RecipePager({
    this.pageSize = 20,
    required this.searchLists,
  });

  List<dynamic> nextBatch() {
    List<dynamic> batch = [];

    for (int i = 0; i < pageSize; i++) {
      int itemIndex = pageIndex * pageSize + i;
      int listIndex = itemIndex ~/ searchLists.length; // Calculate the index of the search list

      if (listIndex >= searchLists.length) break; // Stop if reached the end of all lists

      List<dynamic> currentList = searchLists[listIndex];
      int innerIndex = itemIndex % currentList.length; // Calculate the index within the current list

      if (innerIndex >= currentList.length) break; // Stop if reached the end of the current list

      batch.add(currentList[innerIndex]);
    }

    pageIndex += 1;

    return batch;
  }
}

