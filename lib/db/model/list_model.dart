import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'list_model.g.dart';


@HiveType(typeId: 1)
class ListModel extends HiveObject{
  @HiveField(0)
   int? id;
  @HiveField(1)
     String name;
   @HiveField(2)
   String age;
   @HiveField(3)
    String clas;
   @HiveField(4)
   dynamic image;
   @HiveField(5)
   String place;
  
  ListModel({required this.name, required this.age,required this.clas ,this.id, this.image, required this.place});
}





ValueNotifier<List<ListModel>> studentlistNo = ValueNotifier([]);

   

 Future<void> addstudent (ListModel value) async{
  final show =  await Hive.openBox<ListModel>('student');
   final Id =await show.add(value);
   studentlistNo.value.add(value);
  studentlistNo.notifyListeners();
}


 Future<void> getstudent() async{
final show =  await Hive.openBox<ListModel>('student');
studentlistNo.value.clear();
studentlistNo.value.addAll(show.values);
studentlistNo.notifyListeners();

 }
