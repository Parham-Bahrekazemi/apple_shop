class ProductImageModel {
  String? imageUrl;
  String? productId;

  ProductImageModel(this.imageUrl, this.productId);

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      'http://startflutter.ir/api/files/${json['collectionId']}/${json['id']}/${json['image']}',
      json['product_id'],
    );
  }
}
