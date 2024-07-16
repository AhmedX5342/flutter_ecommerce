import 'package:ecommerce/logic/home_cubit.dart';
import 'package:ecommerce/logic/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..GetProducts(id),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeCubit,HomeState>(
            builder: (context,state){
              if(state is HomeLoading){
                return const Center(child: CircularProgressIndicator());
              }else if(state is HomeSuccess){
                return ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context,index){
                      return Container(
                        color: Colors.grey,
                        child: Row(
                          children: [
                            Image.network(HomeCubit.get(context).products[index].image!, width: 100, height: 100, fit: BoxFit.cover),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(HomeCubit.get(context).products[index].name!),
                                  Text('${HomeCubit.get(context).products[index].price!}'),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: (){

                                          },
                                          icon: const Icon(Icons.favorite, color: Colors.red,)
                                      ),
                                      IconButton(
                                          onPressed: (){

                                          },
                                          icon: const Icon(Icons.shopping_cart, color: Colors.white,)
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context,index){
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: HomeCubit.get(context).products.length
                );
              }else {
                return Text('no data');
              }
            },
          ),
        ),
      ),
    );
  }
}
