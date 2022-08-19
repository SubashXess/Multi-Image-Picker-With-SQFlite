import 'package:flutter/foundation.dart';
import 'package:multi_image_picker_v1/Database/database_helper.dart';
import 'package:multi_image_picker_v1/Model/image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoProvider with ChangeNotifier {
  DBHelper dbHelper = DBHelper();

  late Future<List<ImageModel>> _image;
  Future<List<ImageModel>> get image => _image;

  Future<List<ImageModel>> getData() async {
    _image = dbHelper.getImages();
    return _image;
  }
}
