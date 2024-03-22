import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// import '/services/send_notification.dart';
// import 'package:flutter/material.dart';

// class NotificationView extends StatefulWidget {
//   const NotificationView({super.key});

//   @override
//   State<NotificationView> createState() => _NotificationViewState();
// }

// class _NotificationViewState extends State<NotificationView> {
//   TextEditingController _titleController = TextEditingController();
//   final TextEditingController messageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("Send-Notification page")),
//         body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//              TextField(
//               controller: _titleController,
              
//               decoration: InputDecoration(labelText: 'Title'),
//             ),
//             TextField(
//               controller: messageController,
//               decoration: InputDecoration(labelText: 'Notification Message'),
//            ),
//             SizedBox(height: 20),
//             ElevatedButton(
//                 onPressed: () async {
//                      String message = messageController.text;
//                  if (message.isNotEmpty) {
//                   await NotificationService().sendNotification(
//                       _titleController.text, messageController.text);

//                   _titleController.text = '';
//                   messageController.text = '';
//                 }else {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: Text('Error'),
//                       content: Text('Please enter a message'),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: Text('OK'),
//                         ),
//                       ],
//                     ),
//                   );
//                 }},
//                 child: Text("Submit"))
//           ],
//         )));
//   }
// }