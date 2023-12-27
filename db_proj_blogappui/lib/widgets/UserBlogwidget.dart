import 'package:flutter/material.dart';

import '../pages/Blogpage.dart';

class UserBlogwidget extends StatefulWidget {
  const UserBlogwidget({super.key});

  @override
  State<UserBlogwidget> createState() => _UserBlogwidgetState();
}

class _UserBlogwidgetState extends State<UserBlogwidget> {
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
                        IconButton(
                          color: const Color.fromARGB(255, 136, 132, 132),
                          icon: Icon(Icons.update),
                          onPressed: () {},
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.delete,
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
