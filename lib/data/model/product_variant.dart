import 'package:apple_shop/data/model/variant_model.dart';
import 'package:apple_shop/data/model/variant_type.dart';

class PorductVariantModel {
  VariantTypeModel? variantType;
  List<VariantModel>? variants;

  PorductVariantModel(this.variantType, this.variants);
}
