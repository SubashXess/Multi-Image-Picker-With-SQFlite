// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:multi_image_picker_v1/Database/database_helper.dart';
import 'package:multi_image_picker_v1/Model/image_model.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper? dbHelper = DBHelper();

  // Image add
  File? image;
  String? loadImage;
  File? finalImage;

  @override
  void initState() {
    super.initState();

    dbHelper!.getImageList();
  }

  // final picker = ImagePicker();

  // Future getImage() async {
  //   final pickerImage = await picker.pickImage(source: ImageSource.camera);

  //   setState(() {
  //     if (pickerImage != null) {
  //       _image = File(pickerImage.path);
  //       final imagePermanent = saveImagePermanently(_image!.path);
  //       loadImage = imagePermanent.toString();
  //     } else {
  //       print('No image selected');
  //     }
  //   });
  // }

  // Future<File> saveImagePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${directory.path}/$name');
  //   ImageModel finalImage = ImageModel(id: 0, image: imagePath);
  //   dbHelper!.saveImage(finalImage);
  //   print('Load : $finalImage');
  //   return File(imagePath).copy(image.path);
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Image Picker'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    // height: size.height * 0.18,
                    width: size.height * 0.36,

                    child: Card(
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                              width: 2.0, color: Colors.deepPurple)),
                      child: image == null
                          ? Image.asset(
                              "assets/default-image.png",
                              fit: BoxFit.cover,
                            )
                          : Image.file(image!),
                    ),
                  ),
                  Positioned(
                    top: -10.0,
                    right: -10.0,
                    child: InkWell(
                      onTap: () => pickImage(ImageSource.camera, context),
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickImage(ImageSource source, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      // temporary image
      // final imageTemporary = File(image.path);

      // permanent image
      final imagePermanent = await saveImagePermanently(image.path);

      setState(() {
        // this.image = imageTemporary;
        this.image = imagePermanent;
        loadImage = imagePermanent.toString();
        // set next
        ImageModel imageModel = ImageModel(image: this.image!.path);
        dbHelper!.saveImage(imageModel);

        print('Image Model : ${imageModel.image}');

        print("Load Image : $loadImage");
      });
    } on PlatformException catch (e) {
      print('Failed to pick image : $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }
}
