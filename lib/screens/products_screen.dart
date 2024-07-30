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
    return Scaffold(
      body: BlocProvider(
        create: (context)=>HomeCubit()..GetProducts(id),
        child: SafeArea(
            child: BlocBuilder<HomeCubit,HomeState>(
              builder: (context,state){
                if(state is HomeLoading){
                  return const Center(child: CircularProgressIndicator());
                }else if(state is HomeSuccess){
                  return ListView.separated(
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context,index){
                        var cubit = HomeCubit.get(context); // --------------- <-- solved it
                        return Container(
                          color: Colors.grey,
                          child: Row(
                            children: [
                              // cubit.products[index].image!=null?Image.network(cubit.products[index].image!, width: 100, height: 100, fit: BoxFit.cover): Container(color: Colors.grey.shade200),
                              Image.network(cubit.products[index].image!, width: 100, height: 100, fit: BoxFit.cover),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(cubit.products[index].name!),
                                    Text('${cubit.products[index].price!}'),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: (){
                                              cubit.AddFavorites(context, cubit.products[index].id!, id);
                                            },
                                            icon: Icon(Icons.favorite, color:cubit.products[index].inFavorites==true? Colors.red: Colors.grey,)
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
