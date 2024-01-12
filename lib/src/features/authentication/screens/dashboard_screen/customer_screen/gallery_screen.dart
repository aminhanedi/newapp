import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<XFile> imageFileList = [];

  Future<void> getImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Return to the previous screen
            Navigator.push(context, MaterialPageRoute(builder: (context)=> dashboard()));
          },
        ),
      ),

      body: Center(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: imageFileList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(
                    File(imageFileList[index].path),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Select Images",
        child: Icon(Icons.camera),
      ),
    );
  }
}