// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:multi_image_picker_v1/Database/database_helper.dart';
import 'package:multi_image_picker_v1/Model/image_model.dart';
import 'package:multi_image_picker_v1/Pages/secondpage.dart';
import 'package:multi_image_picker_v1/Provider/imageprovider.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper? dbHelper = DBHelper();

  // second image add
  // Future<File>? imageFile;
  // Image? image;
  // List<ImageModel>? imageList;
  // // ImageModel? imageModel;

  @override
  void initState() {
    super.initState();
    // imageList = [];

    dbHelper!.getImages();
  }

  // Image add
  File? image;
  String? loadImage;
  // File? finalImage;

  // Future<File>? imageFile;
  // Image? imageFromPreferences;

  // pickImageFromCamera(ImageSource source) async {
  //   setState(() {
  //     final imageFile = ImagePicker().pickImage(source: source);
  //   });
  // }

  // loadImageFromPreferences() {
  //   Utility.getImageFromPreferences().then((img) {
  //     if (null == img) {
  //       return;
  //     }
  //     imageFromPreferences = Utility.imageFromBase64String(img);
  //   });
  // }

  // Widget imageFromCamera() {
  //   return FutureBuilder<File>(
  //     future: imageFile,
  //     builder: (context, AsyncSnapshot<File> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         if (null == snapshot.data) {
  //           return const Text(
  //             'Error',
  //             textAlign: TextAlign.center,
  //           );
  //         }
  //         Utility.saveImageToPreferences(
  //             Utility.base64String(snapshot.data!.readAsBytesSync()));
  //         return Image.file(snapshot.data!);
  //       }
  //       if (null != snapshot.error) {
  //         return const Text(
  //           'Error Picking Image',
  //           textAlign: TextAlign.center,
  //         );
  //       }
  //       return const Text(
  //         'No Image Selected',
  //         textAlign: TextAlign.center,
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final photoProvider = Provider.of<PhotoProvider>(context);
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
              // Stack(
              //   clipBehavior: Clip.none,
              //   children: [
              //     SizedBox(
              //       // height: size.height * 0.18,
              //       width: size.height * 0.36,

              //       child: Card(
              //         margin: EdgeInsets.zero,
              //         clipBehavior: Clip.antiAliasWithSaveLayer,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10.0),
              //             side: const BorderSide(
              //                 width: 2.0, color: Colors.deepPurple)),
              //         child: image == null
              //             ? Image.asset(
              //                 "assets/default-image.png",
              //                 fit: BoxFit.cover,
              //               )
              //             : Image.file(image!),
              //             // : imageFromCamera(),
              //       ),
              //     ),
              //     Positioned(
              //       top: -10.0,
              //       right: -10.0,
              //       child: InkWell(
              //         // onTap: () => pickImage(ImageSource.camera, context),
              //         onTap: () {
              //           pickImageFromCamera(ImageSource.camera);
              //         },
              //         child: Container(
              //           padding: const EdgeInsets.all(6.0),
              //           decoration: const BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Colors.red,
              //           ),
              //           child: const Icon(
              //             Icons.camera_alt,
              //             size: 24.0,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 25.0),

              // second
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
                      child:
                          // imageList == null
                          //     ? Image.asset(
                          //         "assets/default-image.png",
                          //         fit: BoxFit.cover,
                          //       )
                          //     : Utility.imageFromBase64String(
                          //         imageList![0].imageTitle.toString()),

                          image == null
                              ? Image.asset(
                                  "assets/default-image.png",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(File(loadImage!)),
                    ),
                  ),
                  Positioned(
                    top: -10.0,
                    right: -10.0,
                    child: InkWell(
                      onTap: () => pickImage(ImageSource.camera, context),
                      // onTap: () {
                      //   pickImageFromCamera();
                      // },

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
              const SizedBox(height: 25.0),
              Card(
                color: Colors.blue,
                child: Card(
                  child: FutureBuilder(
                    future: photoProvider.getData(),
                    builder:
                        (context, AsyncSnapshot<List<ImageModel>> snapshot) {
                      return Image.file(File(snapshot.data![0].imageTitle!));
                    },
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondPage()));
                },
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Second Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // loadImageFromDB() {
  //   dbHelper!.getImages().then((img) {
  //     imageList!.clear();
  //     imageList!.addAll(img);
  //   });
  // }

  // pickImageFromCamera() {
  //   ImagePicker().pickImage(source: ImageSource.camera).then((img) async {
  //     String imgString = Utility.base64String(await img!.readAsBytes());
  //     print(imgString);
  //     ImageModel finalImage = ImageModel(id: 0, imageTitle: imgString);
  //     dbHelper!.saveImage(finalImage);
  //     loadImageFromDB();
  //   });
  // }

  // Future pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;
  //     // permanent image
  //     // final imagePermanent = await saveImagePermanently(image.path);

  //     final String duplicateFilePath = await
  //         getApplicationDocumentsDirectory().toString();

  //         final var fileName = basename()
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image : $e');
  //   }
  // }

  Future pickImage(ImageSource source, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      // temporary image
      // final imageTemporary = File(image.path);

      // permanent image
      final imagePermanent = await saveImagePermanently(image.path);
      print('Image Path : ${image.path}');

      setState(() {
        // this.image = imageTemporary;
        this.image = imagePermanent;
        // loadImage = imagePermanent.toString(); // temp comment
        // set next
        ImageModel imageModel = ImageModel(imageTitle: this.image!.path);
        dbHelper!.saveImage(imageModel);
        loadImage = imageModel.imageTitle;
        print('Database Image : ${imageModel.imageTitle}');
        print('Get Image : ${dbHelper!.getImages()}');

        // print('Image Model : ${imageModel.image}');

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

    // test

    // SharedPreferences preferences = await SharedPreferences.getInstance();

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString('${directory.path}/$name', image.toString());
  }
}
