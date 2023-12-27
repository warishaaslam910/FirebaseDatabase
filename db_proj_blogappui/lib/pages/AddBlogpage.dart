// import 'package:flutter/material.dart';

// class AddBlogpage extends StatefulWidget {
//   const AddBlogpage({super.key});

//   @override
//   State<AddBlogpage> createState() => _AddBlogpageState();
// }

// class _AddBlogpageState extends State<AddBlogpage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                  child: Container(
//                     height: 200,
//                     decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(15),
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/camera.jpg'),
//                           alignment: Alignment.center,
//                           opacity: 0.8,
//                         )),
//                   ),
//               )
//             ],
//           )
//         ],
//       )
//     );
//   }
// }

import 'package:flutter/material.dart';

class AddBlogpage extends StatefulWidget {
  const AddBlogpage({super.key});

  @override
  State<AddBlogpage> createState() => _AddBlogpageState();
}

class _AddBlogpageState extends State<AddBlogpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  // Handle the tap event here, e.g., show a photo picker
                  // or navigate to a new screen for adding a photo.
                  print('Image Clicked!');
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Image.asset(
                      'assets/images/camera.jpg',
                      fit: BoxFit.cover, // Adjust the BoxFit as needed
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
