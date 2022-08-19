import 'package:multi_image_picker_v1/Model/image_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;

  Future<Database?> get database async {
    if (_db != null) {
      return _db;
    }
    return _db = await initDatabase();
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'image.db');
    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database database, int version) async {
    await database.execute(
        'CREATE TABLE imagesaver (id INTEGER PRIMARY KEY, imageTitle TEXT)');
  }

  Future<ImageModel> saveImage(ImageModel image) async {
    Database? dbImage = await database;
    image.id = await dbImage!.insert('imagesaver', image.toMap());
    return image;
  }

  Future<List<ImageModel>> getImages() async {
    Database? dbImage = await database;
    final List<Map<String, dynamic>> queryResult =
        await dbImage!.query('imagesaver');
    return queryResult.map((e) => ImageModel.fromMap(e)).toList();
    // .map((e) => ImageModel.fromJson(e)).toList();
  }

  Future<int> updateImage(ImageModel image) async {
    Database? dbImage = await database;
    return await dbImage!.update('imagesaver', image.toMap(),
        where: 'id = ?', whereArgs: [image.id]);
  }

  Future closeDatabase() async {
    Database? dbImage = await database;
    dbImage!.close();
  }
}
