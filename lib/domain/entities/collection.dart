class CollectionModel {
  final String collectionId;
  final String name;
  final String thumbnail;

  CollectionModel({
    required this.collectionId,
    required this.name,
    required this.thumbnail,
  });

  // factory CollectionModel.fromJson(Map<String, dynamic> json) {
  //   return CollectionModel(
  //     name: json['name'],
  //     thumbnail: json['thumbnail'],
  //   );
  // }

  // factory CollectionModel.fromMap(Map<String, dynamic> map) {
  //   return CollectionModel(
  //     name: map['name'],
  //     thumbnail: map['thumbnail'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'thumbnail': thumbnail,
  //   };
  // }
}