import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:students/addhome.dart';
import 'package:students/db/model/list_model.dart';

class Update extends StatefulWidget {
  dynamic name, age, clas, index, box2, place;

  Update(
      {Key? key,
      this.name,
      this.age,
      this.clas,
      this.index,
      this.box2,
      this.place})
      : super(key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(20)),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.image),
                label: Text('select image')),
            Builder(builder: (context) {
              final data = Hive.box<ListModel>('student');
              final records = data.getAt(widget.index);
              return TextFormField(
                onChanged: (value) {
                  setState(() {
                    records?.name = value;
                    records!.save();
                  });
                },
                initialValue: widget.name,
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
                var fdata = list.getAt(widget.index);
                return TextFormField(
                  onChanged: (value) {
                    setState(() {
                      fdata?.age = value;
                      fdata!.save();
                    });
                  },
                  keyboardType: TextInputType.number,
                  initialValue: widget.age,
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
              var agedata = sdata.getAt(widget.index);
              return TextFormField(
                initialValue: widget.clas,
                onChanged: (value) {
                  setState(() {
                    agedata?.clas = value;
                    agedata!.save();
                  });
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
              var placedata = daa.getAt(widget.index);
              return TextFormField(
                initialValue: widget.place,
                onChanged: (value) {
                  setState(() {
                    placedata?.place = value;
                    placedata!.save();
                  });
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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (ctx) => Add()),
                          (route) => false);
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
