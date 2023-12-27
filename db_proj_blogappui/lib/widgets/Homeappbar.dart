import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class Homeappbar extends StatefulWidget {
  const Homeappbar({super.key});

  @override
  State<Homeappbar> createState() => _HomeappbarState();
}

class _HomeappbarState extends State<Homeappbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Color.fromARGB(255, 230, 158, 51),
      color: Colors.redAccent,
      padding: EdgeInsets.all(25),
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
                  fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          badges.Badge(
            badgeContent: Text(
              "3",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.notifications,
                size: 32,
                color: Colors.white,
              ),
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(7),
            ),
          ),
        ],
      ),
    );
  }
}
