import 'dart:convert';
import 'package:ecommerce/data/banners_model.dart';
import 'package:ecommerce/data/categories_model.dart';
import 'package:ecommerce/data/favorites_model.dart';
import 'package:ecommerce/data/products_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/logic/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String token = '';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit(): super(HomeInitial());

  static HomeCubit get(context)=>BlocProvider.of(context);

  // -------- get categories
  List<CategoriesModel> categories = [];

  Future<void> GetCategories() async{
    emit(HomeLoading());
    var url = Uri.parse("https://student.valuxapps.com/api/categories");

    try{
      final response = await http.get(url);

      var data = json.decode(response.body);
      if(data['status']==true){
        print('success ${data}');
        for (var element in data['data']['data']) {
          categories.add(CategoriesModel.fromJson(element));
        }
        emit(HomeSuccess());
      }else{
        print('failed ${data}');
        emit(HomeError());
      }
    }
    catch(error){
      print(error);
    }
  }

  // --------- get products
  List<ProductsModel> products = [];

  Future<void> GetProducts(int id) async{
    emit(HomeLoading());
    var url = Uri.parse("https://student.valuxapps.com/api/products?category_id=$id");

    try{
      final response = await http.get(url);

      var data = json.decode(response.body);
      if(data['status']==true){
        print('success ${data}');
        for (var element in data['data']['data']) {
          products.add(ProductsModel.fromJson(element));
        }
        emit(HomeSuccess());
      }else{
        print('failed ${data}');
        emit(HomeError());
      }
    }
    catch(error){
      print(error);
    }
  }

  // --------- get banners
  List<BannersModel> banners = [];
  Future<void> GetBanners() async{
    emit(HomeLoading());
    var url = Uri.parse("https://student.valuxapps.com/api/banners");

    try{
      final response = await http.get(url);

      var data = json.decode(response.body);
      if(data['status']==true){
        print('success ${data}');
        for (var element in data['data']) {
          banners.add(BannersModel.fromJson(element));
        }
        emit(HomeSuccess());
      }else{
        print('failed ${data}');
        emit(HomeError());
      }
    }
    catch(error){
      print(error);
    }
  }

  // --------- add favorites
  Future<void> AddFavorites(context, int id,int categoryId) async{
    var url = Uri.parse("https://student.valuxapps.com/api/favorites");

    Map<String,dynamic> data = {
      'product_id':id,
    };

    final headers = {
      'Content-Type':'application/json',
      'Authorization': token
    };

    final body = json.encode(data);
    try{
      final response = await http.post(url,body: body, headers: headers);
      var JsonDecode = json.decode(response.body);
      if(JsonDecode['status']==true){
        print('success ${response.body}');
        GetProducts(categoryId);
        emit(HomeSuccess());
      }else{
        print('failed ${response.body}');
        emit(HomeError());
      }
    }
    catch(error){
      print(error.toString());
    }
  }

  // --------- get favorites
  List<FavoritesModel> favorites = [];
  Future<void> GetFavorites() async{
    emit(HomeLoading());
    var url = Uri.parse("https://student.valuxapps.com/api/favorites");

    final headers = {                                                                 // it's rare when headers are being used in get methods
      'Content-Type':'application/json',
      'Authorization': token
    };

    try{
      final response = await http.get(url, headers: headers);

      var data = json.decode(response.body);
      if(data['status']==true){
        print('success ${data}');
        for (var element in data['data']['data']) {
          favorites.add(FavoritesModel.fromJson(element['product']));
        }
        emit(HomeSuccess());
      }else{
        print('failed ${data}');
        emit(HomeError());
      }
    }
    catch(error){
      print(error);
    }
  }

}