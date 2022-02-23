import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:students/addhome.dart';
import 'package:students/db/model/list_model.dart';



 Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
if(!Hive.isAdapterRegistered(ListModelAdapter().typeId)){
Hive.registerAdapter(ListModelAdapter());
}
await  Hive.openBox<ListModel>('student');
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

late final Box box;

// @override
//   void initState() {
//     super.initState();

//    }

//   @override
//   void dispose() {
//     Hive.close();
//     super.dispose();
//   }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorDark: Colors.black,
      ),
    home: Add(),
    );
  }
}