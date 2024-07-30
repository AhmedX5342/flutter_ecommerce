class ProductsModel {
  int? id;
  String? name;
  String? image;
  String? Description;
  num? price;
  bool? inFavorites;

  ProductsModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    image = json['description'];
    inFavorites = json['in_favorites'];
  }
}