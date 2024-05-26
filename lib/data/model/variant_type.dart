class VariantTypeModel {
  String? id;
  String? name;
  String? title;
  VariantTypeEnum? type;

  VariantTypeModel(this.id, this.name, this.title, this.type);

  factory VariantTypeModel.fromJson(Map<String, dynamic> json) {
    return VariantTypeModel(
      json['id'],
      json['name'],
      json['title'],
      _getTypeEnum(json['type']),
    );
  }
}

VariantTypeEnum _getTypeEnum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.color;
    case 'Storage':
      return VariantTypeEnum.storage;
    case 'Voltage':
      return VariantTypeEnum.voltage;
    default:
      return VariantTypeEnum.color;
  }
}

enum VariantTypeEnum {
  color,
  storage,
  voltage,
}
