class ProductsModel {
  int? id;
  String? name;
  String? image;
  num? price;

  ProductsModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
  }
}