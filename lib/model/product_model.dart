class ProductModel {
  int? id;
  String? name;
  int? price;
  String? pic;
  int count;
  ProductModel({this.id, this.name, this.price, this.pic, this.count = 0});

  ProductModel counter({int? Count = 0}) {
    return ProductModel(count: Count = 0);
  }
}
