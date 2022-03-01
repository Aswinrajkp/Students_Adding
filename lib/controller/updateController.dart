import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:students/db/model/list_model.dart';

class UpdateController extends GetxController{
  var usableImage1;
 settingName(ListModel list,value){
list.name = value;
list.save();
update();
 }
 settingAge(ListModel list,value){
list.age = value;
list.save();
update();
 }
 settingClas(ListModel list,value){
list.clas = value;
list.save();
update();
 }
 settingPlace(ListModel list,value){
list.place = value;
list.save();
update();
 }

 Future pickImage(images) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final imagepath = await getApplicationDocumentsDirectory();
    final photo = File('${imagepath.path}/${image!.name}');
     File(image.path).copy(photo.path);
     if(image.path == null){
       usableImage1 = 'asset/images/studentslogo.jpg';
   update();
     }
     else{
         usableImage1 = (photo.path);
         update();
            }
    images.image = usableImage1;
    images.save();
    update();
    

  }
}