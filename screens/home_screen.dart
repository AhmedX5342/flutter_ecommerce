import 'package:ecommerce/logic/home_cubit.dart';
import 'package:ecommerce/logic/home_states.dart';
import 'package:ecommerce/screens/products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context)=>HomeCubit()..GetCategories(),
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Categories(), // categories
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context,state){
        return SizedBox(
          height: 120,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context,index){
                var cubit = HomeCubit.get(context);
                if(state is HomeSuccess) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsScreen(id: cubit.categories[index].id!)));
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(HomeCubit.get(context).categories[index].image!),
                          radius: 40,
                        ),
                        Text(HomeCubit.get(context).categories[index].name!)
                      ],
                    ),
                  );
                }else if(state is HomeLoading){
                  return Center(child: CircularProgressIndicator());
                }else{
                  return Center(child: Text('Categories are empty'));
                }
              },
              separatorBuilder: (context,index){
                return SizedBox(width: 10);
              },
              itemCount: HomeCubit.get(context).categories.length
          ),
        );
      }
      ,
    );
  }
}
