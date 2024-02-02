import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';

class BackupWidget extends StatefulWidget {
  @override
  _BackupWidgetState createState() => _BackupWidgetState();
}

class _BackupWidgetState extends State<BackupWidget> {
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> createDatabaseBackup() async {
    final dataRef = FirebaseDatabase.instance.ref();
    final backupData = await dataRef.get().then((DataSnapshot snapshot) => snapshot.value);

    print('Backup Data: $backupData'); // Print the backupData object for debugging purposes

    final directory = await getApplicationDocumentsDirectory();
    final backupFile = File('${directory.path}/backup.json');
    await backupFile.writeAsString(jsonEncode(backupData));
   CircularProgressIndicator();

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text('${AppLocalizations.of(context)!.backupCompleted} ${backupFile.path}',textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.green,backgroundColor: Colors.white,),),
        ));

    print('Backup completed successfully! File saved at: ${backupFile.path}');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Backup Screen'),
      ),
      body: Container(
        padding: EdgeInsets.all(20), 
          margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/img.jpg"),
            Text(AppLocalizations.of(context)!.toProtectYour,style: TextStyle(fontSize: 18),),
            SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {
                createDatabaseBackup();
              },
              child: SizedBox(
                  child:Text(AppLocalizations.of(context)!.createBackup,style: TextStyle(fontSize: 20,),)),
            ),
          ],
        ),
      ),
    );
  }
}