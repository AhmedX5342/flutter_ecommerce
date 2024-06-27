import 'dart:convert';

import 'package:ecommerce/logic/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../screens/home_screen.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit(): super(AuthInitial());
  static AuthCubit get(context)=>BlocProvider.of(context);

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  Future<void> Login(context) async{
    emit(AuthLoading());
    var url = Uri.parse("https://student.valuxapps.com/api/login");

    Map<String,dynamic> data = {
      'email':emailController.text,
      'password':passwordController.text
    };

    final headers = {
      'Content-Type':'application/json'
    };

    final body = json.encode(data);
    try{
      final response = await http.post(url,body: body, headers: headers);
      if(json.decode(response.body)['status']=='true'){
        print('success ${response.body}');
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        emit(AuthSuccess());
      }else{
        print('failed ${response.statusCode}');
        emit(AuthError());
      }
    }
    catch(error){
      print(error);
    }
  }

  Future<void> Signup() async{
    emit(AuthLoading());
    var url = Uri.parse("https://student.valuxapps.com/api/register");

    Map<String,dynamic> data = {
      'name':nameController.text,
      'phone':phoneController.text,
      'email':emailController.text,
      'password':passwordController.text
    };

    final headers = {
      'Content-Type':'application/json'
    };

    final body = json.encode(data);
    try{
      final response = await http.post(url,body: body, headers: headers);
      if(json.decode(response.body)['status']=='true'){
        print('success ${response.body}');
        emit(AuthSuccess());
      }else{
        print('failed ${response.statusCode}');
        emit(AuthError());
      }
    }
    catch(error){
      print(error);
    }
  }
}