import 'package:flutter/material.dart';

class AddBlogpage extends StatefulWidget {
  const AddBlogpage({super.key});

  @override
  State<AddBlogpage> createState() => _AddBlogpageState();
}

class _AddBlogpageState extends State<AddBlogpage> {
  var titlecontroller = TextEditingController();
  var desccontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              color: Colors.redAccent,
              padding: EdgeInsets.fromLTRB(25, 30, 25, 25),
              child: Row(
                children: [
                  Icon(
                    Icons.sort,
                    size: 30,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      "My Blog",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle the tap event here, e.g., show a photo picker
                    // or navigate to a new screen for adding a photo.
                    print('Image Clicked!');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Color(0xFFEDECF2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 55,
                            color: Color.fromARGB(255, 184, 181, 181),
                            onPressed: () {
                              ///////////////////////image functionality/////////////////
                            },
                            icon: Icon(Icons.add_a_photo),
                          ),
                          SizedBox(height: 8), // Adjust the spacing as needed
                          Text(
                            "Add Photo",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Scrollbar(
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: titlecontroller,
                      minLines: 2,
                      maxLines: 20,
                      decoration: InputDecoration(
                        labelText: "Title",
                        hintText: "Enter Title",
                        labelStyle: TextStyle(
                          color: Colors.redAccent,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: desccontroller,
                      minLines: 2,
                      maxLines: 20,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.redAccent,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.redAccent),
                        ),
                        labelText: "Description",
                        hintText: "Enter Description",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
