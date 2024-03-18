import 'dart:io';

import 'package:db_proj_blogappui/pages/AddBlogpage.dart';
import 'package:db_proj_blogappui/pages/UserBlogpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/Login.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  User? currentuser = FirebaseAuth.instance.currentUser;
  final storageref = FirebaseStorage.instance.ref("IMAGEFOLDER");
  final key = FirebaseAuth.instance.currentUser!.uid; //user key
  String? _profilePictureUrl; //to upload profile img
  //profile image
  File? _profileimageFile;
  UniqueKey _imageKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    // Load the profile picture URL from shared preferences
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _profilePictureUrl = prefs.getString('profilePictureUrl');
        _profileimageFile = _loadImageFile(prefs.getString('profileImagePath'));
      });
    });
  }

  Future<void> _uploadProfilePicture() async {
    if (_profileimageFile != null) {
      try {
        String imagePath = 'profile_pics/$key.jpg/$_imageKey';
        await storageref.child(imagePath).putFile(_profileimageFile!);
        _profilePictureUrl = await storageref.child(imagePath).getDownloadURL();

        // Save the URL to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('profilePictureUrl', _profilePictureUrl!);
        prefs.setString('profileImagePath', _profileimageFile!.path);

        setState(() {
          _imageKey = UniqueKey();
        });
      } catch (e) {
        print('Error uploading profile picture: $e');
      }
    }
  }

  File? _loadImageFile(String? path) {
    return path != null ? File(path) : null;
  }

  Future<void> pickprofileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileimageFile = File(pickedFile.path);
      });

      await _uploadProfilePicture();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'username',
              style: TextStyle(fontSize: 15),
            ),
            accountEmail: Text(
              currentuser?.email ?? 'email@gmail.com',
              style: TextStyle(fontSize: 15),
            ),
            currentAccountPicture: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: _profileimageFile != null
                          ? Image.file(
                              _profileimageFile!,
                              key: _imageKey,
                              height: 190,
                              width: 190,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              'https://plus.unsplash.com/premium_photo-1683121769247-7824fdc324de?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              height: 190,
                              width: 190,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    hoverColor: Colors.black,
                    onTap: () async {
                      pickprofileImage();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 4, color: Colors.white),
                        color: Colors.grey,
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
          ),
          ListTile(
            leading: Icon(Icons.my_library_books),
            title: Text('My Blogs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserBlogpage(
                    blogID: '',
                    blogDescription: '',
                    blogTitle: '',
                    ind: '',
                    dbref: FirebaseDatabase.instance.ref("Appusers"),
                    imageurl: '',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Post'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBlogpage(
                    updatepostid: '',
                    likescount: 0,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
