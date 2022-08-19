class ImageModel {
  int? id;
  String? image;

  ImageModel({this.id, this.image});

  factory ImageModel.fromJson(Map<String, dynamic> resource) {
    return ImageModel(
      id: resource['id'],
      image: resource['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
      };
}
