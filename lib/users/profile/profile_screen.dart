import 'dart:io';
import 'package:baisnab/users/theme.dart/theme.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import '../craud/changepassword.dart';
import '../theme.dart/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  User? _user;
  String _imageUrl = '';
  String _username = '';

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _pickImage() async {
    print('Attempting to pick image...');
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    print('File picked: $pickedFile');

    if (pickedFile == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance
        .ref(); // this is used to create the document in the firebase storage to store
    Reference referenceDirImages = referenceRoot.child(
        'images'); // this is used to create the folder inside the firestore storage in the name of images
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(
          pickedFile.path ?? '')); // this is used to image to upload the file

      String imageUrl = await referenceImageToUpload
          .getDownloadURL(); //used to get the urllimnk of the image that we have store on the  storage
      print('Image uploaded successfully. URL: $imageUrl');

      setState(() {
        _imageUrl = imageUrl;
      });

      await _updateUserProfile(imageUrl);
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> _fetchUserProfile() async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        User? user = await _auth.userChanges().first;

        setState(() {
          _user = user;
        });

        print("User UID: ${_user!.uid}");
        print("User Email: ${_user!.email}");

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('userslist')
            .doc(_user!.uid)
            .get();

        if (userSnapshot.exists) {
          String username = userSnapshot['username'];
          String imageUrl = userSnapshot['imageUrl']; 

          print("Username from Firestore: $username");
          print("Image URL from Firestore: $imageUrl");

          setState(() {
            _username = username;
            _imageUrl = imageUrl;
          });
        } else {
          print("User profile not found in Firestore");
        }
      } else {
        print("User not authenticated");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _updateUserProfile(String imageUrl) async {
    try {
      if (_user != null) {
        await FirebaseFirestore.instance
            .collection('userslist')
            .doc(_user!.uid)
            .update({'imageUrl': imageUrl});

        setState(() {
          imageUrl =
              imageUrl; 
        });

        print('User profile updated in Firestore with new image URL');
      } else {
        print('User not authenticated');
      }
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  Widget _buildPickedImage() {
    return CircleAvatar(
      radius: 60, /// this is used to increase the width of the uploaded image 
      backgroundImage:
          CachedNetworkImageProvider(_imageUrl), // Use CachedNetworkImage
    );
  }

  Widget _buildDottedBorder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 140,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 254, 5, 5)),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text('No Image'),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Center(
      child: Column(
       
        children: [
          _imageUrl.isNotEmpty ? _buildPickedImage() : _buildDottedBorder(),
          TextButton(
            onPressed: () {
              _pickImage();
            },
            
            child: Text('Choose an image'),
          ),
        ],
      ),
    );
  }
  @override
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final themeProvider = Provider.of<ThemeNotifier>(context);
    return Consumer<ThemeNotifier>(builder: (context, themeProvider, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getTheme(),
          home: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: 40,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_sharp),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 20),
                        
                            child: Text(
                              " Profile", 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                 
                     Column(
                   
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        _buildImagePicker(),
                    
                        SizedBox(height: 10),
                        Text(
                          'Email: ${_user?.email ?? "N/A"}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Username: $_username',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                         Divider(),
              
                          Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height:90),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:2.0),
                                child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePasswordScreen(),
                                  ));
                            },
                           
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/change.png',
                                        height: 65.0,
                                        width: 65.0,
                                      ),
                                      const SizedBox(width: 10.0),
                                      const Text("Change Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),), 
                      ],
                    ),
                
                ],
              ),
            ),
       )
       )
       );
    }
        );
      }
    
  }

