
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students/addhome.dart';
import 'package:students/db/model/list_model.dart';


class AddingStudent extends StatefulWidget {


  
  const AddingStudent({ Key? key }) : super(key: key);

  @override
  _AddingStudentState createState() => _AddingStudentState();
}

class _AddingStudentState extends State<AddingStudent> {

final namecontroller = TextEditingController();
final agecontroller = TextEditingController();
final clascontroller = TextEditingController();
final placecontroller = TextEditingController();
File? photo;
final formKey = GlobalKey<FormState>();





Future pickImage()async{
 
   final photo =await ImagePicker().pickImage(source: ImageSource.gallery);
    if(photo == null ) 
    return;


  
   final imageTemporary = File(photo.path);
   setState(() => this.photo = imageTemporary);
    

  
 }



  @override
  Widget build(BuildContext context) {
    getstudent();
    return SafeArea(
      child: Scaffold(
        
        appBar: AppBar(
         backgroundColor: Colors.black,
         centerTitle: true,
         title: Text('Enter the Details of students'),
        ),
        body: Container(
        
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Form(
            key: formKey,
            child: ListView(
              children:[
                 Padding(padding: EdgeInsets.all(20)),

                  CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xffFDCF09),
              child: photo != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        photo!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          
              
               
                TextButton.icon(onPressed: (){
                 pickImage();
                }, icon: Icon(Icons.image) , label: Text('select image')),
                SizedBox(
                  height: 20,
                ),
            
                Builder(
                  builder: (context) {
               
                    return TextFormField(
                      controller: namecontroller,
                      validator: (value){
                       if (value!.isEmpty || value==null) {
                         return '*required';
                       }
                      },
                     decoration: InputDecoration(
                       contentPadding: EdgeInsets.only(left: 30),
                       hintText: 'name',
                       hintStyle: TextStyle(color: Colors.black),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(60)),
                       )
                     ),
                    );
                  }
                ),
                 SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: agecontroller,
                  keyboardType: TextInputType.number,
                 decoration: InputDecoration(
                   contentPadding: EdgeInsets.only(left: 30),
                   hintText: 'age',
                   hintStyle: TextStyle(color: Colors.black),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(60)),  
                   ),
                  
                 ),
                 validator: (value){
                   if(value!.isEmpty || value == null ){
                     return 'required';
                   }
                 },
                ),
                 SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: clascontroller,
                 decoration: InputDecoration(
                   contentPadding: EdgeInsets.only(left: 30),
                   hintText: 'class',
                   hintStyle: TextStyle(color: Colors.black),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(60)),
                   ),
                   fillColor: Colors.greenAccent
                   
                 ),
                 validator:(value){
                   if(value!.isEmpty || value == null){
                     return 'required';
                   }
                 },
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: placecontroller,
                 decoration: InputDecoration(
                   contentPadding: EdgeInsets.only(left: 30),
                   hintText: 'place',
                   hintStyle: TextStyle(color: Colors.black),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(60)),
                   ),
                   fillColor: Colors.greenAccent
                   
                 ),
                 validator:(value){
                   if(value!.isEmpty || value == null){
                     return 'required';
                   }else if (value.trim().isEmpty) {
                     return 'please enter a place';
                   }
                 },
                ),
                SizedBox(
                  height: 25,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  ElevatedButton(
                    
                   style: ElevatedButton.styleFrom(
                     primary: Colors.red,
                   ),
                   onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=> Add() ),(route) => false );
                 }, child: Text('cancel')),
                 SizedBox(
                   width: 20,
                 ),
                 ElevatedButton(
                  style: ElevatedButton.styleFrom(
                     primary: Colors.green,
                   ), 
                   onPressed: (){
                     if(formKey.currentState!.validate()){
                        checking();
                     }
                
                 }, child: Text('add'))
                 
                ],
              )
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }

  Future<void> checking() async{
  final name = namecontroller.text.trim();
  final age = agecontroller.text.trim();
  final clas = clascontroller.text.trim();
  final place = placecontroller.text.trim();
  if(name.isEmpty || age.isEmpty || clas.isEmpty){
    return ;
   
  }else{
    final details = ListModel(name: name, age: age, clas: clas, image: photo, place: place);
 addstudent(details);
 Navigator.pop(context);
  }
    
  }

       
}




