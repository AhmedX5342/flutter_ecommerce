import 'dart:convert';
import 'package:ecommerce/data/categories_model.dart';
import 'package:ecommerce/data/products_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/logic/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

}