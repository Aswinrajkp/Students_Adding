import 'dart:io';

import 'package:flutter/material.dart';
import 'package:students/db/model/list_model.dart';
import 'package:students/widgets/student_adding.dart';

class Details extends StatelessWidget {
  String name, age, clas, place;
  var image;
  Details(
      {Key? key,
      required this.name,
      required this.age,
      required this.clas,
      required this.place,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            CircleAvatar(
                maxRadius: 140, backgroundImage: backgroundImage(image)),
            Padding(padding: EdgeInsets.all(0)),
            Text('$name',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900,color: Colors.white)),
            SizedBox(
              height: 20,
            ),
            Text(
              'age : $age',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700,color: Colors.white),
            ),
            Text(
              ' class : $clas',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25,color: Colors.white),
            ),
            Text(
              ' place : $place',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  backgroundImage(list) {
    if (list != null) {
      return FileImage(File(list));
    } else {
      return AssetImage('asset/images/studentslogo.jpg');
    }
  }
}
