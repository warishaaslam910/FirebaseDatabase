// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter/material.dart';

// int like = 0;

// class Home extends StatefulWidget {
//   final String postID;
//   final Image postImage;
//   final DatabaseReference dref;
//   final String ind;

//   Home(
//       {Key? key,
//       required this.postID,
//       required this.postImage,
//       required this.dref,
//       required this.ind})
//       : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         scrollDirection: VerticalDirection,
//         child: Column(
//           children: [
//             Expanded(
//                 child: StreamBuilder(
//                     stream: widget.dref.child(widget.ind).onValue,
//                     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//                       if (!snapshot.hasData) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         return Text("Error : ${snapshot.error}");
//                       } else if (snapshot.data!.snapshot.value == null) {
//                         //IT IS TO SHOW THAT YOU ARE SURE THAT THE VALUE IS NOT NULL
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       } else {
//                         List<Object?> list = [];
//                         list = snapshot.data!.snapshot.value as List<Object?>;

//                         return ListView.builder(
//                           itemBuilder: (context, index) {
//                             Object? items = list[index];
//                             if (items is Map<dynamic, dynamic>) {
//                               return Padding(
//                                 padding: EdgeInsets.fromLTRB(8, 8, 8, 12),
//                                 child: myCustomListTile(items),
//                               );
//                             } else if (items == null) {
//                               return Container();
//                             }
//                           },
//                           itemCount: list.length,
//                         );
//                       }
//                     }))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget myCustomListTile(Map<dynamic, dynamic> items) {
//     return NeumorphicButton(
//       onPressed: () {},
//       style: NeumorphicStyle(
//         shape: NeumorphicShape.flat,
//         boxShape: NeumorphicBoxShape.rect(),
//       ),
//       padding: const EdgeInsets.all(12.0),
//       child: Expanded(
//         child: ListTile(
//           title: widget.postImage,
//           subtitle: SizedBox(
//             width: 20,
//             child: Row(
//               children: [
//                 IconButton(
//                     iconSize: 20,
//                     icon: const Icon(
//                       Icons.favorite,
//                       color: Color.fromARGB(255, 214, 26, 20),
//                     ),
//                     // the method which is called
//                     // when button is pressed
//                     onPressed: () {
//                       setState(
//                         () {
//                           like++;
//                         },
//                       );
//                     }),
//                 IconButton(
//                     iconSize: 100,
//                     icon: const Icon(
//                       Icons.comment,
//                     ),
//                     // the method which is called
//                     // when button is pressed
//                     onPressed: () {
//                       setState(
//                         () {
//                           like++;
//                         },
//                       );
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String postID;
  final Image postImage;
  final DatabaseReference dref;
  final String ind;

  Home({
    Key? key,
    required this.postID,
    required this.postImage,
    required this.dref,
    required this.ind,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isliked = false;
  int likecount = 0;

  void togglefavourite() {
    setState(() {
      if (isliked) {
        likecount -= 1;
        isliked = false;
      } else {
        likecount += 1;
        isliked = true;
      }
    });
  }

  void showmymodelsheet() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return CommentSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: widget.dref.child(widget.ind).onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.data!.snapshot.value == null) {
                  // IT IS TO SHOW THAT YOU ARE SURE THAT THE VALUE IS NOT NULL
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<Object?> list = [];
                  list = snapshot.data!.snapshot.value as List<Object?>;

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      Object? items = list[index];
                      if (items is Map<dynamic, dynamic>) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
                          child: myCustomListTile(items),
                        );
                      } else if (items == null) {
                        return Container();
                      }
                    },
                    itemCount: list.length,
                    shrinkWrap: true, // Add this property
                    // physics:
                    //     NeverScrollableScrollPhysics(), // Add this property
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget myCustomListTile(Map<dynamic, dynamic> items) {
    return NeumorphicButton(
      onPressed: () {},
      style: NeumorphicStyle(
        color: Colors.white,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        depth: 8,
        lightSource: LightSource.topLeft,
      ),
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
        title: widget.postImage,
        subtitle: SizedBox(
          width: 20,
          child: Row(
            children: [
              IconButton(
                iconSize: 35,
                icon: (isliked
                    ? const Icon(
                        Icons.favorite,
                        color: Color.fromARGB(255, 214, 26, 20),
                      )
                    : const Icon(
                        Icons.favorite_border_outlined,
                        color: Color.fromARGB(255, 214, 26, 20),
                      )),
                onPressed: () {
                  togglefavourite();
                },
              ),
              IconButton(
                iconSize: 35,
                icon: const Icon(
                  Icons.comment,
                ),
                onPressed: () {
                  showmymodelsheet();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentSheet extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Comments',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
                // Your comment list goes here
                ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Add a comment',
            ),
            onFieldSubmitted: (comment) {
              // Handle adding a new comment here
            },
          ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
