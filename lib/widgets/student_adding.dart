import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/getcontroller.dart';
import 'package:students/db/model/list_model.dart';

class AddingStudent extends StatelessWidget {
  AddingStudent({Key? key}) : super(key: key);

  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final clascontroller = TextEditingController();
  final placecontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenController controller = Get.put(ScreenController());
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
              children: [
                Padding(padding: EdgeInsets.all(20)),
                GetBuilder<ScreenController>(builder: (controller) {
                  return GestureDetector(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Color(0xffFDCF09),
                      child: controller.usableImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                File(controller.usableImage!),
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.wallpaper),
                                  Text('Select an image'),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 200,
                              height: 150,
                            ),
                    ),
                    onTap: () => controller.pickImage(),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      controller: namecontroller,
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return '*required';
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 30),
                          hintText: 'name',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                          )),
                    ),
                  );
                }),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
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
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'required';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: clascontroller,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30),
                        hintText: 'class',
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
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    controller: placecontroller,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30),
                        hintText: 'place',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                        ),
                        fillColor: Colors.greenAccent),
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'required';
                      } else if (value.trim().isEmpty) {
                        return 'please enter a place';
                      }
                    },
                  ),
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
                        onPressed: () {
                          Get.back();
                          Get.delete<ScreenController>();
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
                            checking(controller);
                          }
                        },
                        child: Text('add'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> checking(controller) async {
    final name = namecontroller.text.trim();
    final age = agecontroller.text.trim();
    final clas = clascontroller.text.trim();
    final place = placecontroller.text.trim();
    if (name.isEmpty || age.isEmpty || clas.isEmpty) {
      return;
    } else {
      final details = ListModel(
          name: name,
          age: age,
          clas: clas,
          image: controller.usableImage,
          place: place);
      addstudent(details);
      Get.back();
    }
  }
}
