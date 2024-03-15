import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

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
  Future<void> downloadBackupAsPdf() async {
    final dataRef = FirebaseDatabase.instance.ref();
    final backupData =
    await dataRef.get().then((DataSnapshot snapshot) => snapshot.value);

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('$backupData'),
          );
        },
      ),
    );

    final filePickerResult = await FilePicker.platform.getDirectoryPath();
    if (filePickerResult != null) {
      final backupFile = File('$filePickerResult/backup.pdf');
      await backupFile.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Backup downloaded as PDF: ${backupFile.path}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.green,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      );

      print('Backup downloaded as PDF. File saved at: ${backupFile.path}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Backup location not selected.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      );

      print('Backup location not selected.');
    }
  }

  Future<void> createDatabaseBackup() async {
    final dataRef = FirebaseDatabase.instance.ref();
    final backupData =
    await dataRef.get().then((DataSnapshot snapshot) => snapshot.value);

    print('Backup Data: $backupData');

    final directory = await getApplicationDocumentsDirectory();
    final backupFile = File('${directory.path}/backup.json');
    await backupFile.writeAsString(jsonEncode(backupData));
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
              Container(
                height: 150,
                color: Colors.blue,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(width: 20.0, height: 1.0),
                    const Text(
                      'Be',
                      style: TextStyle(fontSize: 43.0),
                    ),
                    const SizedBox(width: 20.0, height: 40.0),
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Horizon',
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('AWESOME'),
                          RotateAnimatedText('OPTIMISTIC'),
                          RotateAnimatedText('DIFFERENT'),
                        ],
                        repeatForever: true,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Lottie.asset('assets/images/backup.json', height: 400),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
                child: Text(
                  AppLocalizations.of(context)!.toProtectYour,
                  style: TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  downloadBackupAsPdf();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black,
                  side: BorderSide(color: Colors.black, width: 1),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Download Backup as PDF',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                height: 20,
              ),
            ],
          ),
      ),
    );
  }
}