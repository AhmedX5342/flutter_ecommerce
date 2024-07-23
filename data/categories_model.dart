class CategoriesModel {
  int? id;
  String? name;
  String? image;

  CategoriesModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}