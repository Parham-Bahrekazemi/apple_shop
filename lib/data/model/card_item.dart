import 'package:hive/hive.dart';

part 'card_item.g.dart';

@HiveType(typeId: 0)
class BasketItemModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? collectionId;
  @HiveField(2)
  String? thumbnail;
  @HiveField(3)
  int discountPrice;
  @HiveField(4)
  int price;
  @HiveField(5)
  String? name;
  @HiveField(6)
  String? category;
  @HiveField(7)
  int? finalPrice;
  @HiveField(8)
  num? prsent;
  BasketItemModel(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.discountPrice,
    this.price,
    this.name,
    this.category,
  ) {
    finalPrice = price - discountPrice;
    prsent = ((price - finalPrice!) / price) * 100;
    // 'http://startflutter.ir/api/files/${json['collectionId']}/${json['id']}/${json['thumbnail']}',
  }
}
