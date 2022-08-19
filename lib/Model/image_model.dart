class ImageModel {
  int? id;
  String? imageTitle;

  ImageModel({this.id, this.imageTitle});

  ImageModel.fromMap(Map<dynamic, dynamic> resource)
      : id = resource['id'],
        imageTitle = resource['imageTitle'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'imageTitle': imageTitle,
    };
  }
}
