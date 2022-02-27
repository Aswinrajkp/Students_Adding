import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:students/widgets/student_adding.dart';
import 'package:students/controller/getcontroller.dart';
import 'package:students/db/model/list_model.dart';
import 'package:students/widgets/details.dart';
import 'package:students/widgets/update.dart';

class Add extends StatelessWidget {
  const Add({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<ListModel>('student');
    ScreenController controller = Get.put(ScreenController());
    getstudent();
    return GetBuilder<ScreenController>(
        builder: (controller) => Scaffold(
          backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search,color: Colors.white,),
                    hintText: 'Students',
                    hintStyle: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700),
                  ),
                  onChanged: (value) => controller.filterStudents(value),
                ),
               
              ),
              floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
              floatingActionButton: floatingAction(),
              body: ValueListenableBuilder(
                valueListenable: studentlistNo,
                builder: (BuildContext ctx, List<ListModel> studentlist,
                    Widget? child) {
                  final box = Hive.box<ListModel>('student');
                  return controller.foundStudents.isEmpty
                      ? Center(
                          child: Text('no result found'),
                        )
                      : ListView.builder(
                          itemCount: controller.foundStudents.length,
                          itemBuilder: (ctx, index) {
                            int index3 = index + 1;
                            int index2 = studentlist.indexWhere((element) =>
                                element.name.contains(
                                    controller.foundStudents[index].name));
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 12, 0, 0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 38,
                                  backgroundImage:
                                      backgroundImage(studentlist[index2].image),
                                ),
                                onTap: () {
                                  goingDetails(studentlist, index2);
                                },
                                title: Text(
                                  controller.foundStudents[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20,
                                      color: Colors.white),
                                ),
                                textColor: Colors.black,
                                trailing: wrapWidget(index, context),
                              ),
                            );
                          },
                        );
                },
              ),
            ));
  }

  backgroundImage(list) {
    if (list != null) {
      return FileImage(File(list));
    } else {
      return AssetImage('asset/images/studentslogo.jpg');
    }
  }

  floatingAction() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(AddingStudent());
      },
      backgroundColor: Colors.white,
      child: Icon(Icons.add,color: Colors.black,),
    );
  }

  goingUpdate(index2) {
    Get.to(Update(
      name: controller.foundStudents[index2].name,
      age: controller.foundStudents[index2].age,
      clas: controller.foundStudents[index2].clas,
      index: index2,
      box2: controller.foundStudents,
      place: controller.foundStudents[index2].place,
      image: controller.foundStudents[index2].image,
    ));
  }

  goingDetails(studentlist, index2) {
    Get.to(Details(
      name: studentlist[index2].name,
      age: studentlist[index2].age,
      clas: studentlist[index2].clas,
      place: studentlist[index2].place,
      image: studentlist[index2].image,
    ));
  }

  delete(index, context) {
    final delete = Hive.box<ListModel>('student');

    delete.deleteAt(index);
    getstudent();
    Navigator.pop(context);
  }

  wrapWidget(index2, context) {
    return Wrap(
      spacing: 10.0,
      children: [
        IconButton(
            onPressed: () {
              goingUpdate(index2);
            },
            icon: Icon(Icons.edit),color: Colors.grey,),
        IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Delete',
                middleText: 'Are you sure',
                cancel: TextButton(onPressed: (){Get.back();}, child: Text("cancel")),
                confirm: TextButton(onPressed: (){delete(index2, context);}, child: Text("Delete",style: TextStyle(color: Colors.red),))
              );
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return AlertDialog(
              //         title: Text("Delete"),
              //         content: Text('Are you sure ?'),
              //         actions: <Widget>[
              //           TextButton(
              //             onPressed: () {
              //               Navigator.pop(context);
              //             },
              //             child: Text("No"),
              //           ),
              //           TextButton(
              //               onPressed: () {
              //                 
              //               },
              //               child: Text('Yes'))
              //         ],
              //       );
              //     });
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ],
    );
  }
}
