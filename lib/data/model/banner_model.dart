class BannerModel {
  String? categoryId;
  String? collectionId;
  String? id;
  String? thumbnail;

  BannerModel(this.categoryId, this.collectionId, this.id, this.thumbnail);

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      json['categoryId'],
      json['collectionId'],
      json['id'],
      'http://startflutter.ir/api/files/${json['collectionId']}/${json['id']}/${json['thumbnail']}',
    );
  }
}
