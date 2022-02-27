import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:students/db/model/list_model.dart';

class ScreenController extends GetxController {
  RxList foundStudents = [].obs;
  List result = [];
 var usableImage ;

 

  filterStudents(String student) {
    if (student.isEmpty) {
      result = studentlistNo.value;
    } else {
      result = studentlistNo.value
          .where((element) =>
              element.name.toLowerCase().contains(student.toLowerCase()))
          .toList();
    }
    foundStudents.value = result;
    update();
  }

  @override
  void onInit() {
    foundStudents.value = studentlistNo.value;
    // TODO: implement onInit
    super.onInit();
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final imagepath = await getApplicationDocumentsDirectory();
    final photo = File('${imagepath.path}/${image!.name}');
     File(image.path).copy(photo.path);
     if(image.path == null){
       usableImage = 'asset/images/studentslogo.jpg';
   update();
     }
     else{
         usableImage = (photo.path);
         update();
            }
  }
 @override
  void dispose() {
    
    // TODO: implement dispose
    super.dispose();
  }
}