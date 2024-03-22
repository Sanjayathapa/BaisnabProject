import 'package:baisnab/Admin/adminscreen/addrecipe.dart';
import 'package:baisnab/Admin/adminscreen/edit.dart';
import 'package:baisnab/Admin/adminscreen/editaddedrecipe.dart';
import 'package:baisnab/Admin/adminscreen/messagebox.dart';
import 'package:baisnab/Admin/adminscreen/orderlist.dart';
import 'package:baisnab/Admin/adminscreen/recipelist.dart';
import 'package:baisnab/Admin/adminscreen/userlist.dart';
import 'package:baisnab/Admin/onesignal/onesignal.dart';
import 'package:baisnab/users/craud/login_screen.dart';
import 'package:provider/provider.dart';
import '../../users/short/short.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baisnab/model/model.dart';

import '../providers/dark_theme_provider.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // This will remove the back button
          title: Text(
            'Admin Page',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [

          Consumer<MessageCountProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: Stack(
                  children: [
                    Icon(Icons.message),
                    if (provider.newMessageCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: _buildBadge(provider.newMessageCount),
                      ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MessagePage()),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logout(context);
            },
          ),
        ],
        ),
        body: SafeArea(child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AdminCard(
                                title: 'Edit-Recipe',
                                image: 'assets/1200px-SVG-edit_logo.svg.png',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminEditCartPage(),
                                    ),
                                  );
                                  print('Edit pressed');
                                },
                              ),
                              SizedBox(height: 16),
                              AdminCard(
                                title: ' User List',
                                image: 'assets/4791601.png',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserListScreen(),
                                    ),
                                  );
                                  print('Add User List pressed');
                                },
                              ),
                              SizedBox(height: 16),
                              AdminCard(
                                title: 'Add Recipe',
                                image: 'assets/add-1-ico.png',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddRecipeScreen(),
                                    ),
                                  );
                                  print('Order List pressed');
                                },
                              ),
                              SizedBox(height: 16),
                              AdminCard(
                                title: 'Order List',
                                image: 'assets/orders-list-vector-17727433.jpg',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderListScreen(),
                                    ),
                                  );
                                  print('Order List pressed');
                                },
                              ),
                              AdminCard(
                                title: 'View Recipe-list',
                                image: 'assets/restaurant.jpg',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminRecipeList(),
                                    ),
                                  );
                                  print('Add User List pressed');
                                },
                              ),
                              AdminCard(
                                title: 'Edit  Added Recipe-list',
                                image:
                                    'assets/45.jpg', // Replace with actual image path
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AdminEditaddedPage(),
                                    ),
                                  );
                                  print('edit  added-recipe List pressed');
                                },
                              ),
                              // AdminCard(
                              //   title: 'Send Notification',
                              //   image:
                              //       'assets/notification.png', // Replace with actual image path
                              //   onPressed: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => NotificationView(),
                              //       ),
                              //     );
                              //     print('send notification pressed');
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                //   ),
                // ]),
              ),
            );
          },
        )));
  }
}
 Widget _buildBadge(int count) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      constraints: BoxConstraints(
        minWidth: 16,
        minHeight: 16,
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }