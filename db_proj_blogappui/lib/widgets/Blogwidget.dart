import 'package:db_proj_blogappui/widgets/Likebtn.dart';
import 'package:flutter/material.dart';

import '../pages/Blogpage.dart';

class Blogwidget extends StatefulWidget {
  const Blogwidget({super.key});

  @override
  State<Blogwidget> createState() => _BlogwidgetState();
}

class _BlogwidgetState extends State<Blogwidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Blogpage()));
                },
                child: Hero(
                  tag: "blogImage",
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage('assets/images/$index.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.8,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Blog Title",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    //////////like btn
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Likebtn(
                          isLiked: false,
                          onTap: () {},
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.comment_outlined,
                              size: 24,
                              color: const Color.fromARGB(255, 136, 132, 132),
                            ),
                          ),
                        )
                      ],
                    ),

                    ////////////like count ////////
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
