

import 'package:flutter/material.dart';


class Details extends StatelessWidget {

String name,age,clas,place;

   Details({ Key? key ,required this.name,required this.age,required this.clas,required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Details'),
      ),
      body: Center(
        child: Column(
          children: [
            
            Padding(padding: EdgeInsets.all(50)),
            
            Text('$name',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w900 )),
            SizedBox(
              height: 20,
            ),
            Text('age : $age', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
            Text(' class : $clas',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            Text(' place : $place',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
          ],
        ),
      ),
    );
  }
}