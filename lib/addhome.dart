
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:students/adding.dart';
import 'package:students/db/model/list_model.dart';
import 'package:students/details.dart';
import 'package:students/update.dart';




class Add extends StatefulWidget {
  const Add({ Key? key }) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}
String search ="";
class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context)
   {final box = Hive.box<ListModel>('student');
      getstudent();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: TextField(
          decoration:InputDecoration(
            hintText:'search student',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
          ),
          onChanged: (value){
          setState(
            () {
          search  = value;
          });
          },
        ),
  
        actions: [
          IconButton(onPressed: (){
          }, icon: Icon(Icons.search,color:Colors.black,))
        ],
      ),
      
      floatingActionButton : FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=> AddingStudent()));
      },
      backgroundColor: Colors.black,
      child: Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        
        valueListenable: studentlistNo,
        builder: (BuildContext ctx, List<ListModel> studentlist , Widget? child){
     
     final box =  Hive.box<ListModel>('student');
        var     results = search.isEmpty
             ?studentlistNo.value.toList()
             :studentlistNo.value.where((element) => element.name.toLowerCase().contains(search.toLowerCase())).toList();
            
          
          return results.isEmpty
          ?Center(
            child: Text('no result found'),
          )
          : ListView.separated(
            
            itemCount: results.length,
            itemBuilder: (ctx ,index){
                   
          return ListTile(
     leading: CircleAvatar(
       radius: 38,
       backgroundImage: AssetImage('asset/images/studentslogo.jpg'),
     ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Details( name: studentlist[index].name,age: studentlist[index].age,clas: studentlist[index].clas, place: studentlist[index].place, )));
            },
            title: Text(results[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            textColor: Colors.black,   
            trailing:
            Wrap(
              spacing: 10.0,
              children: [
                IconButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Update(name:results[index].name ,age: results[index].age,clas: results[index].clas,index: index, box2: studentlist,place: results[index].place,)));
            }, 
            icon: Icon(Icons.edit)),

            
             IconButton(onPressed: (){
            showDialog(context: context, builder: (context){
              return
      AlertDialog(
        title: Text("Delete"),
        content: Text('Are you sure ?'),
        actions: <Widget>[
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("No"),),
          TextButton(onPressed: (){
               final delete =  Hive.box<ListModel>('student');
            
            delete.deleteAt(index);
            getstudent();
            Navigator.pop(context);
            
          }, child: Text('Yes'))
        ],
      );
    });
            }, icon: Icon(Icons.delete,color: Colors.red,)),   
              ],
            )
            
          );
        },
         separatorBuilder:(ctx, index){
           return Divider(color: Colors.black26,thickness: 5);
         });
        },
        
      ),
      );
  }

}

