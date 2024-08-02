import 'package:carousel_slider/carousel_slider.dart';
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
        create: (context)=>HomeCubit()..GetCategories()..GetBanners()..GetFavorites(),
        child: const SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Categories(), // categories
                  SizedBox(height: 20),
                  HomeCarousel(), // carousel
                  Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  SizedBox(height: 20),
                  HomeGridView() // gridView
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ----------- categories
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

// ----------- carousel
class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context,state) {
        var cubit = HomeCubit.get(context);
        return (state is HomeLoading)? const Center(child: CircularProgressIndicator()): // is state is loading, display the circular progress indicator. else: display the carousel
          CarouselSlider(
          options: CarouselOptions(
              height: 200.0,
              viewportFraction: 1,
              aspectRatio: 16/9,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3)
          ),
          items: cubit.banners.map((i) {
            return
              i.image !=null? // if img not null
              Image.network(
                  height: 200,
                  width: 400,
                  fit: BoxFit.cover,
                  i.image!
              ): // display the image
              Container(color: Colors.grey); // else: display a grey container
          }).toList(),
        );
      },
    );
  }
}

// ----------- grid view
class HomeGridView extends StatelessWidget {
  const HomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1/1.6, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemCount: cubit.favorites.length,
            itemBuilder: (context, index){
              return Container(
                padding: const EdgeInsets.all(10),
                color: Colors.grey.shade200,
                child: Expanded(
                  child: Column(
                    children: [
                      Image.network(cubit.favorites[index].image!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover
                      ),
                      Text(cubit.favorites[index].name!)
                    ],
                  ),
                ),
              ) ;
            }
        );
      },
    );
  }
}


