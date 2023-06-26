// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_core/firebase_core.dart' as firebase_core;
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// class MyHomePage extends StatelessWidget {
//   final picker = ImagePicker();

//   Future<String> uploadImageToFirebase(File image) async {
//     try {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       firebase_storage.Reference ref =
//           firebase_storage.FirebaseStorage.instance.ref().child();
//       firebase_storage.UploadTask uploadTask = ref.putFile(image);
//       firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading image to Firebase Storage: $e');
//       throw Exception('Error uploading image to Firebase Storage');
//     }
//   }

//   Future<void> pickAndUploadImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       File image = File(pickedFile.path);
//       String imageUrl = await uploadImageToFirebase(image);

//       // Perform further actions with the uploaded image URL
//       print('Uploaded image URL: $imageUrl');
//     } else {
//       print('No image selected.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Upload'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: pickAndUploadImage,
//           child: Text('Select Image and Upload'),
//         ),
//       ),
//     );
//   }
// }