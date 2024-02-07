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
  List<XFile> imageFileList = []; // A list to store selected image files

  Future<void> getImage() async {
    final ImagePicker imagePicker = ImagePicker(); // Create an instance of ImagePicker
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage(); // Open the image picker to select multiple images

    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages); // Add the selected images to the imageFileList
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
        child: Icon(Icons.photo_camera_back),
      ),
    );
  }
}