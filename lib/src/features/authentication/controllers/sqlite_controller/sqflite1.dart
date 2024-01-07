import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController tecId = TextEditingController();
  TextEditingController tecData = TextEditingController();
  var myData = "";
  late Database database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myDB();
  }

  void myDB()async{
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + "/myDatabase.db";


    // open the database
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE MyData('
                  'id INTEGER PRIMARY KEY,'
                  'data TEXT)');

          // await db.execute(
          //     'CREATE TABLE Contact('
          //         'id INTEGER PRIMARY KEY,'
          //         'title TEXT,'
          //         'description varchar(200),'
          //         'date datetime');
        });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(controller: tecId, decoration: InputDecoration(hintText: "Id ..."),),
              TextField(controller: tecData, decoration: InputDecoration(hintText: "Enter ..."),),
              Wrap(
                children: [
                  ElevatedButton(onPressed: (){
                    database.insert("myData", {"id": int.parse(tecId.text), "data": tecData.text});
                    setState(() {
                      tecId.clear();
                      tecData.clear();
                      myData = "";
                    });
                  }, child: Text("Save Data")),
                  ElevatedButton(onPressed: (){}, child: Text("Display by id")),
                  ElevatedButton(onPressed: ()async{
                    var maps = await database.query("myData");
                    for(var map in maps){
                      myData += map['data'] as String;
                      myData += "\n";
                    }
                    setState(() {});
                  }, child: Text("Display All")),
                  ElevatedButton(onPressed: (){}, child: Text("Delete by id")),
                  ElevatedButton(onPressed: (){}, child: Text("update by id")),

                ],
              ),
              Text(myData)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    database.close();
  }
}



