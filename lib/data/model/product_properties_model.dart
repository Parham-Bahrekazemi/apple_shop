class ProdutPropertiesModel {
  String? title;
  String? value;

  ProdutPropertiesModel(this.title, this.value);

  factory ProdutPropertiesModel.fromJson(Map<String, dynamic> json) {
    return ProdutPropertiesModel(
      json['title'],
      json['value'],
    );
  }
}
