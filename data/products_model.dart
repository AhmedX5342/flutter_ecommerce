class ProductsModel {
  int? id;
  String? name;
  String? image;
  String? description;
  num? price;
  bool? inFavorites;

  ProductsModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    inFavorites = json['in_favorites'];
  }
}