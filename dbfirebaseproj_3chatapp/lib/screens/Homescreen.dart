import 'package:dbfirebaseproj_3chatapp/helper/Apis.dart';
import 'package:dbfirebaseproj_3chatapp/models/Chatuser.dart';
import 'package:dbfirebaseproj_3chatapp/screens/Profilescr.dart';

//right code
import 'package:dbfirebaseproj_3chatapp/widgets/Chatcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Chatuser> list = [];
  final List<Chatuser> searchlist = [];
  bool _issearching = false;
  @override
  void initState() {
    super.initState();
    APIs.getselfinfo();

    SystemChannels.lifecycle.setMessageHandler((message) {
      print('Message:$message');

      //for updating user status accordig to lifecycle events
      //resume --active or onine
      //pause--inactive or offline
      if (APIs.auth.currentUser !=
          null) //THIS COND IS GIVEN SOIF THE USER LOGOUTS IT NO LONGER SHOW ACTIVE
      {
        if (message.toString().contains('resume')) {
          APIs.UpdateActiveStatus(true);
        }

        if (message.toString().contains('pause')) {
          APIs.UpdateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_issearching) {
            setState(() {
              _issearching = !_issearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            title: _issearching
                ? TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'NAME,EMAIL...'),
                    autofocus: true,
                    style: TextStyle(fontSize: 17, letterSpacing: 0.5),
                    onChanged: (val) {
                      searchlist.clear();
                      for (var i in list) {
                        if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                            i.email.toLowerCase().contains(val.toLowerCase())) {
                          searchlist.add(i);
                        }
                        setState(() {
                          searchlist;
                        });
                      }
                    },
                  )
                : Text('My Chats'),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _issearching = !_issearching;
                    });
                  },
                  icon: Icon(
                    _issearching ? Icons.close_rounded : Icons.search,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Profilescr(user: APIs.me)));
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ))
            ],
          ),
          body: StreamBuilder(
              stream: APIs.getallusers(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  //active done to replace (has data) to show there is some or whole data present
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs; //add only if not null ?
                    list = data
                            ?.map((e) => Chatuser.fromJson(e.data()))
                            .toList() ??
                        [];
                    if (list.isNotEmpty) {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount:
                              _issearching ? searchlist.length : list.length,
                          itemBuilder: (context, index) {
                            return Chatcard(
                              user: _issearching
                                  ? searchlist[index]
                                  : list[index],
                            );
                          });
                    } else {
                      return Center(
                        child: Text('No Connection found'),
                      );
                    }
                }

                // final list = [];
                // if (snapshot.hasData) {
                //   final data = snapshot.data?.docs; //add only if not null ?
                //   for (var i in data!) {
                //     // print('Data : $i.data()');
                //     print('Data : ${jsonEncode(i.data())}');
                //     list.add(i.data()['name']);
                //   } //! we are sure that it will be not null
                // }
                // return ListView.builder(
                //     physics: BouncingScrollPhysics(),
                //     itemCount: list.length,
                //     itemBuilder: (context, index) {
                //       //return Chatcard();
                //       return Text('NAME : ${list[index]}');
                //     });
              }),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
              },
              child: Icon(Icons.logout),
            ),
          ),
        ),
      ),
    );
  }
}
