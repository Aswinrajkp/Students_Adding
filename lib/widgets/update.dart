
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:students/widgets/home.dart';
import 'package:students/controller/updateController.dart';
import 'package:students/db/model/list_model.dart';

class Update extends StatelessWidget {
  dynamic name, age, clas, index, box2, place,image;
  final formKey = GlobalKey<FormState>();
  Update(
      {Key? key,
      this.name,
      this.age,
      this.clas,
      this.index,
      this.box2,
      this.place,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpdateController controller = Get.put(UpdateController());
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(20)),
            Builder(builder: (context){
                final Imagedata = Hive.box<ListModel>('student');
                final images = Imagedata.getAt(index);
                return
                GestureDetector(
                  onTap: () =>  controller.pickImage(images!),
                        child: Center(child: Text("Change Image",style: TextStyle(color: Colors.black,fontSize: 19),)),
                       );
            }),
            SizedBox(height: 30,),
            Builder(builder: (context) {
              final data = Hive.box<ListModel>('student');
              final records = data.getAt(index);
              return TextFormField(
                onChanged: (value) {
                  controller.settingName(records!, value);
                },
                initialValue: name,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return '*required';
                  }
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 30),
                    label: Text(
                      'name',
                      style: TextStyle(color: Colors.black),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                    )),
              );
            }),
            SizedBox(
              height: 19,
            ),
            Builder(
              builder: (context) {
                var list = Hive.box<ListModel>('student');
                var fdata = list.getAt(index);
                return TextFormField(
                  onChanged: (value) {
                    controller.settingAge(fdata!, value);
                  },
                  keyboardType: TextInputType.number,
                  initialValue: age,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 30),
                    label: Text(
                      'age',
                      style: TextStyle(color: Colors.black),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'required';
                    }
                  },
                );
              },
            ),
            SizedBox(
              height: 19,
            ),
            Builder(builder: (context) {
              var sdata = Hive.box<ListModel>('student');
              var agedata = sdata.getAt(index);
              return TextFormField(
                initialValue: clas,
                onChanged: (value) {
                  controller.settingClas(agedata!, value);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 30),
                    label: Text(
                      'class',
                      style: TextStyle(color: Colors.black),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                    ),
                    fillColor: Colors.greenAccent),
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return 'required';
                  }
                },
              );
            }),
            SizedBox(
              height: 19,
            ),
            Builder(builder: (context) {
              var daa = Hive.box<ListModel>('student');
              var placedata = daa.getAt(index);
              return TextFormField(
                initialValue: place,
                onChanged: (value) {
                  controller.settingPlace(placedata!, value);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 30),
                    label: Text(
                      'place',
                      style: TextStyle(color: Colors.black),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                    ),
                    fillColor: Colors.greenAccent),
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return 'required';
                  }
                },
              );
            }),
            SizedBox(
              height: 19,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      Get.off(Add());
                    },
                    child: Text('cancel')),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.of(context).pop();
                        getstudent();
                      }
                    },
                    child: Text('add'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
