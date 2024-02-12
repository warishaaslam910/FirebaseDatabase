//right code

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbfirebaseproj_3chatapp/Snackbardialog.dart';
import 'package:dbfirebaseproj_3chatapp/helper/Apis.dart';
import 'package:dbfirebaseproj_3chatapp/main.dart';
import 'package:dbfirebaseproj_3chatapp/models/Chatuser.dart';
import 'package:dbfirebaseproj_3chatapp/screens/auth/Loginscr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class Profilescr extends StatefulWidget {
  final Chatuser user;
  const Profilescr({super.key, required this.user});

  @override
  State<Profilescr> createState() => _ProfilescrState();
}

class _ProfilescrState extends State<Profilescr> {
  final _formkey = GlobalKey<FormState>();
  String? _image;
  // void initState() {
  //   super.initState();
  //   APIs().getselfinfo();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.home_outlined,
            color: Colors.black,
          ),
          title: Text('Profile'),
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .03,
                  ),
                  Stack(
                    children: [
                      //profile pic here
                      _image != null
                          ?
                          //local img
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(mq.height * .1),
                              child: Image.file(
                                File(_image!),
                                width: mq.width * .2,
                                height: mq.height * .2,
                                fit: BoxFit.fill,
                              ),
                            )
                          :
                          //img from server
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(mq.height * .1),
                              child: CachedNetworkImage(
                                width: mq.width * .2,
                                height: mq.height * .2,
                                fit: BoxFit.fill,
                                imageUrl: widget.user.image,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(child: Icon(Icons.person)),
                              ),
                            ),

                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: MaterialButton(
                            shape: CircleBorder(),
                            elevation: 1,
                            color: Colors.white,
                            onPressed: () {
                              _showmodelbottomsheet();
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: mq.height * .03,
                  ),
                  Text(
                    widget.user.email,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: mq.height * .03,
                  ),
                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => APIs.me.name = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'required field',
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Enter Name',
                      label: Text('Name'),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => APIs.me.about = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'required field',
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.info,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Enter About',
                      label: Text('About'),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          minimumSize: Size(mq.width * .5, mq.height * .05)),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          APIs.updateuserinfo().then((value) => {
                                Snackbardialog.showSnackbar(
                                    context, 'Profile Updated Successfully')
                              });
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 28,
                      ),
                      label: Text(
                        'UPDATE',
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              ),
            ),
          ),
        ),
        // FloatingActionButton(onPressed: (){},),
        floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: FloatingActionButton.extended(
              onPressed: () async {
                Snackbardialog.showprogbar(context);

                await APIs.UpdateActiveStatus(false);
                await FirebaseAuth.instance.signOut().then((value) async {
                  await GoogleSignIn().signOut().then((value) {
                    //FOR HIDING PROGRESS DIALOG
                    Navigator.pop(context);
                    //FOR MOVING TO HOME SCREEN
                    Navigator.pop(context);
                    APIs.auth = FirebaseAuth.instance;
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => Loginscr()));
                  });
                });
              },
              label: Text('Logout'),
              icon: Icon(Icons.logout),
            )),
      ),
    );
  }

  void _showmodelbottomsheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: mq.height * .02),
            children: [
              Text(
                'Select Profile picture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        //pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          print(
                              'image path :${image.path}-- Mimetype: ${image.mimeType}');
                        }
                        setState(() {
                          _image = image!.path;
                        });
                        APIs.updateprofilepicture(File(_image!));
                        //hide ottom sheet after selecting
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/gallery.png')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        //pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          print('image path :${image.path}');
                        }
                        setState(() {
                          _image = image!.path;
                        });
                        APIs.updateprofilepicture(File(_image!));
                        //hide ottom sheet after selecting
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/camera1.png'))
                ],
              ),
            ],
          );
        });
  }
}
