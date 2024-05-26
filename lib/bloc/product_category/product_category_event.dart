abstract class ProductCategoryEvent {}

class ProductCategoryGetInfoEvent extends ProductCategoryEvent {
  String categoryId;
  ProductCategoryGetInfoEvent(this.categoryId);
}
