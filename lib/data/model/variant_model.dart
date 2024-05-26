class VariantModel {
  String? id;
  String? name;
  String? typeId;
  String? value;
  int? priceChange;

  VariantModel(
    this.id,
    this.name,
    this.typeId,
    this.value,
    this.priceChange,
  );

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      json['id'],
      json['name'],
      json['type_id'],
      json['value'],
      json['price_change'],
    );
  }
}
