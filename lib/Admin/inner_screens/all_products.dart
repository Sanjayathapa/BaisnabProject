// import 'package:baisnab/model/model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../controllers/menu_controller.dart';
// import '../responsive.dart';
// import '../services/utils.dart';
// import '../widgets/grid_products.dart';
// import '../widgets/header.dart';
// import '../widgets/side_menu.dart';
// import '../controllers/menu_controller.dart' as MyAppMenuController;
// import '../controllers/menu_controller.dart' as AdminMenuController;

// class AllProductsScreen extends StatefulWidget {
//   const AllProductsScreen({Key? key}) : super(key: key);

//   @override
//   State<AllProductsScreen> createState() => _AllProductsScreenState();
// }

// class _AllProductsScreenState extends State<AllProductsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = Utils(context).getScreenSize;
//     return Scaffold(
//       // key
//     //  key: context.read<MyAppMenuController.MenuController>().getScaffoldKey,
//       drawer: const SideMenu(),
//       body: SafeArea(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // We want this side menu only for large screen
//             if (Responsive.isDesktop(context))
//               const Expanded(
//                 // default flex = 1
//                 // and it takes 1/6 part of the screen
//                 child: SideMenu(),
//               ),
//             Expanded(
//               // It takes 5/6 part of the screen
//                 flex: 5,
//                 child: SingleChildScrollView(
//                   controller: ScrollController(),
//                   child: Column(
//                     children: [
//                       const SizedBox(
//                         height: 25,
//                       ),
//                       // Header
//                       // Header(
//                       //   // fct: () {
//                       //   //  context.read<AdminMenuController.MenuController>().controlAddProductsMenu();
//                       //   // },
//                       //   title: 'All products',
//                       // ),

//                       const SizedBox(
//                         height: 25,
//                       ),
//                       Responsive(
//                         mobile: ProductGridWidget(
//                           crossAxisCount: size.width < 650 ? 2 : 4,
//                           childAspectRatio:
//                           size.width < 650 && size.width > 350 ? 1.1 : 0.8,
//                           isInMain: false,  
//                            recipe: Recipe(
//                 recipeId: 'id',
//                 recipeTitle: 'Recipe Title',
//                 recipename: 0.0,
//                 cookingTime: 'Cooking Time',
//                 rating: 0.0,
//                 description: 'Description',
//                 image: 'Image URL',
//               ),
//                         ),
//                         desktop: ProductGridWidget(
//                           childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
//                           isInMain: false,
//                             recipe: Recipe(
//                 recipeId: 'id',
//                 recipeTitle: 'Recipe Title',
//                 recipename: 0.0,
//                 cookingTime: 'Cooking Time',
//                 rating: 0.0,
//                 description: 'Description',
//                 image: 'Image URL',
//               ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

