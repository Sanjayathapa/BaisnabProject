// import '../controllers/menu_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../controllers/menu_controller.dart' as MyAppMenuController;
// import '../controllers/menu_controller.dart' as AdminMenuController;
// import '../responsive.dart';
// import '../services/utils.dart';
// import '../widgets/header.dart';
// import '../widgets/orders_list.dart';
// import '../widgets/side_menu.dart';

// class AllOrdersScreen extends StatefulWidget {
//   const AllOrdersScreen({Key? key}) : super(key: key);

//   @override
//   State<AllOrdersScreen> createState() => _AllOrdersScreenState();
// }

// class _AllOrdersScreenState extends State<AllOrdersScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = Utils(context).getScreenSize;
//     return Scaffold(
//       // key
//       //  key: context.read<MyAppMenuController.MenuController>().getScaffoldKey,
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
//                       // header
//                       Header(showTexField: false,
//                         fct: () {
//                            context.read<AdminMenuController.MenuController>().controlAllOrder();
//                         },
//                         title: 'All Orders',
//                       ),

//                       const SizedBox(
//                         height: 20,
//                       ),
//                       // OrdersList
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         // child: OrdersList(
//                         //   isInDashboard: false,
//                         // ),
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

