import 'dart:io'; // Importing the 'dart:io' library for file operations
import 'dart:convert'; // Importing the 'dart:convert' library for JSON encoding/decoding
import 'package:flutter/material.dart'; // Importing the Flutter Material package
import 'package:firebase_core/firebase_core.dart'; // Importing the Firebase Core package
import 'package:firebase_database/firebase_database.dart'; // Importing the Firebase Realtime Database package
import 'package:path_provider/path_provider.dart'; // Importing the 'path_provider' package for getting the application document directory
import 'package:flutter_gen/gen_l10n/app-localization.dart'; // Importing the generated localization package

class BackupWidget extends StatefulWidget {
  @override
  _BackupWidgetState createState() => _BackupWidgetState();
}

class _BackupWidgetState extends State<BackupWidget> {
  @override
  void initState() {
    super.initState();
    initializeFirebase(); // Initializing Firebase when the widget is initialized
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(); // Initializing the Firebase app
  }

  Future<void> createDatabaseBackup() async {
    final dataRef = FirebaseDatabase.instance.ref(); // Getting a reference to the Firebase Realtime Database
    final backupData =
    await dataRef.get().then((DataSnapshot snapshot) => snapshot.value); // Retrieving the data from the database

    print('Backup Data: $backupData'); // Printing the backupData object for debugging purposes

    final directory = await getApplicationDocumentsDirectory(); // Getting the application document directory
    final backupFile = File('${directory.path}/backup.json'); // Creating a backup file in the document directory
    await backupFile.writeAsString(jsonEncode(backupData)); // Writing the backup data to the file in JSON format
    CircularProgressIndicator();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '${AppLocalizations.of(context)!.backupCompleted} ${backupFile.path}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.green,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );

    print('Backup completed successfully! File saved at: ${backupFile.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
            Image.asset("assets/images/img.jpg"), // Displaying an image
            Text(
              AppLocalizations.of(context)!.toProtectYour, // Localized text
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                createDatabaseBackup(); // Triggering the backup creation when the button is pressed
              },
              style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
              ),
              child: SizedBox(
                child: Text(
                  AppLocalizations.of(context)!.createBackup, // Localized button text
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}