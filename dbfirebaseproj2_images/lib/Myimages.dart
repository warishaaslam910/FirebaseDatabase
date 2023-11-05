import 'dart:io';

import 'package:dbfirebaseproj2_images/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'Login.dart';

class Myimages extends StatefulWidget {
  const Myimages({super.key});

  @override
  State<Myimages> createState() => _MyimagesState();
}

class _MyimagesState extends State<Myimages> {
  DatabaseReference dref = FirebaseDatabase.instance.ref("POSTS");
  final key = FirebaseAuth.instance.currentUser!.uid;
  int id = 0;
/////////// for image////////////
  File? image;
  final Imagepicker = ImagePicker();
  final storageref = FirebaseStorage.instance.ref("IMAGEFOLDER");

  Future getimgfromgallery() async {
    final pickedFile = await Imagepicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);

    setState(() {});
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      toastmsg("No image selected !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 235, 156, 39),
        title: Text("Posts"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login())));
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image == null ? Text("No image here") : Image.file(image!.absolute),
            ElevatedButton(
                onPressed: () {
                  getimgfromgallery();
                },
                child: Text('Select Image')),
            ElevatedButton(
                onPressed: () async {
                  id++;
                  final refimg =
                      await storageref.child("img").child("$key/$id");
                  UploadTask uploadTask = refimg.putFile(image!.absolute);

                  Future.value(uploadTask).then((value) async {
                    final downloadurl =
                        await refimg.getDownloadURL(); //URL OPTION
                    Image postimage = Image.file(image!);
                    dref
                        .child(key)
                        .child("$id")
                        .set({"Id": id, "imageurl": downloadurl}).then((value) {
                      toastmsg("image uploaded in database");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                    postID: id.toString(),
                                    postImage: postimage, //image
                                    ind: key,
                                    dref: dref,
                                  )));
                    }).onError((error, stackTrace) {
                      toastmsg(error.toString());
                    });
                  });
                },
                child: Text('Upload Image')),
          ],
        ),
      ),
    );
  }
}

void toastmsg(msg) async {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Color.fromARGB(255, 6, 6, 190),
    textColor: Colors.red,
    fontSize: 16.0,
  );
}
