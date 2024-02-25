import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<XFile> imageFileList = []; // A list to store selected image files
  Map<String, String> imageNames = {}; // A map to store image names
  int currentIndex = 0; // Index of the currently displayed image

  Future<void> getImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile>? selectedImages =
    await imagePicker.pickMultiImage(); // Open the image picker to select multiple images

    if (selectedImages != null && selectedImages.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter Image Names'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < selectedImages.length; i++)
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        imageNames[selectedImages[i].path] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Image ${i + 1} Name'),
                  ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    imageFileList.addAll(selectedImages);
                  });
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: imageFileList.length,
        itemBuilder: (BuildContext context, int index) {
          final String imagePath = imageFileList[index].path;
          final String imageName = imageNames[imagePath] ?? '';

          return GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index; // Set the current index to the tapped image
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryView(
                    imageFileList: imageFileList,
                    currentIndex: currentIndex,
                    imageNames: imageNames,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  image: FileImage(File(imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      imageName,
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add),
      ),
    );
  }
}

class GalleryView extends StatelessWidget {
  final List<XFile> imageFileList;
  final int currentIndex;
  final Map<String, String> imageNames;

  const GalleryView({
    required this.imageFileList,
    required this.currentIndex,
    required this.imageNames,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery View'),
      ),
      body: PhotoViewGallery.builder(
        itemCount: imageFileList.length,
        builder: (BuildContext context, int index) {
          final String imagePath = imageFileList[index].path;
          final String imageName = imageNames[imagePath] ?? '';

          return PhotoViewGalleryPageOptions(
            imageProvider: FileImage(File(imagePath)),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
            heroAttributes: PhotoViewHeroAttributes(tag: imagePath),
            onTapUp: (context, details, controllerValue) {
              Navigator.pop(context);
            },
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        pageController: PageController(initialPage: currentIndex),
        loadingBuilder: (context, event) => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}