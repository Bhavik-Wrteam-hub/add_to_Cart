import 'package:add_to_cart/cubit/cart_cubit.dart';

import 'package:add_to_cart/cubit/favorite_cubit.dart';
import 'package:add_to_cart/cubit/filter_cubit.dart';
import 'package:add_to_cart/data/model/favorite_model.dart';
import 'package:add_to_cart/data/model/product_model.dart';
import 'package:add_to_cart/screen/add_cart_screen.dart';
import 'package:add_to_cart/screen/favorite_list_screen.dart';
import 'package:add_to_cart/data/repository/product_list.dart';
import 'package:add_to_cart/screen/product_details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchc = TextEditingController();
  List<ProductModel> foundproduct = [];
  bool infavoriteList = false;
  int currentIndex = 0;

  @override
  void initState() {
    foundproduct = Const.product;
    context.read<CartCubit>().fetchCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Product List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favorite');
            },
            icon: const Icon(Icons.favorite),
            color: Colors.amber,
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.amber,
            )),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: BlocBuilder<FilterCubit, FavoriteModel>(
                builder: (context, state) {
                  return TextFormField(
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    onChanged: (value) {
                      foundproduct = context
                          .read<FilterCubit>()
                          .filterProductsByName(value);
                      setState(() {});
                    },
                    controller: searchc,
                    decoration: InputDecoration(
                      hintText: "Search Product...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                // ListView.builder(
                //   scrollDirection: Axis.horizontal,
                //   shrinkWrap: true,
                //   itemCount: Const.product.length,
                //   itemBuilder: (context, index) {
                //     return Container(
                //       margin: const EdgeInsets.all(6.0),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8.0),
                //         image: const DecorationImage(
                //           image: NetworkImage(
                //               "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     );
                //   },
                // ),
                Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1524678606370-a47ad25cb82a?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                          "https://graphicsfamily.com/wp-content/uploads/2020/07/Face-Wash-Packaging-Design-Presentation-1180x664.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1544117519-31a4b719223d?q=80&w=1952&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    print(reason.toString());
                    currentIndex = index;
                  });
                },
                scrollDirection: Axis.horizontal,
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.9,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                      height: 13,
                      width: 13,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color:
                              currentIndex == i ? Colors.amber : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(1, 2),
                                color: Colors.grey)
                          ]))
              ],
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: foundproduct.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Navigator.pushNamed(context, '/product',
                          arguments: {'productModel': foundproduct[index]});
                    } else if (index == 1) {
                      Navigator.pushNamed(context, '/product',
                          arguments: {'productModel': foundproduct[index]});
                    } else if (index == 2) {
                      Navigator.pushNamed(context, '/product',
                          arguments: {'productModel': foundproduct[index]});
                    } else if (index == 3) {
                      Navigator.pushNamed(context, '/product',
                          arguments: {'productModel': foundproduct[index]});
                    } else if (index == 4) {
                      Navigator.pushNamed(context, '/product',
                          arguments: {'productModel': foundproduct[index]});
                    } else if (index == 5) {
                      Navigator.pushNamed(context, '/product',
                          arguments: {'productModel': foundproduct[index]});
                    } else if (index == 6) {
                      Navigator.pushNamed(context, '/product',
                          arguments: {'productModel': foundproduct[index]});
                    } else if (index == 7) {
                      Navigator.pushNamed(context, '/product',
                          arguments: {'productModel': foundproduct[index]});
                    } else if (index == 8) {
                      Navigator.pushNamed(context, '/product',
                          arguments: {'productModel': foundproduct[index]});
                    } else if (index == 9) {
                      Navigator.pushNamed(
                        context,
                        '/product',
                        arguments: {
                          'productModel': foundproduct[index],
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      child: Stack(
                        children: [
                          ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Image.network(
                                    fit: BoxFit.fill,
                                    foundproduct[index].pic.toString()),
                              ),
                            ),
                            title: Text(
                              foundproduct[index].name.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Price :- ${foundproduct[index].price}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BlocBuilder<FavoriteCubit, FavoriteModel>(
                                  builder: (context, state) {
                                    infavoriteList = context
                                        .read<FavoriteCubit>()
                                        .inFavoriteList(foundproduct[index]);
                                    return Container(
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: const Text(
                                                  'Click ok button to add the favorite'),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const SizedBox(
                                                    child: Text("Cancel"),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);

                                                    print(
                                                        "this is the in favoriteList :-$infavoriteList");
                                                    context
                                                        .read<FavoriteCubit>()
                                                        .addFavoriteList(
                                                            product:
                                                                foundproduct[
                                                                    index]);
                                                  },
                                                  child: const SizedBox(
                                                    child: Text("okay"),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          infavoriteList == true
                                              ? Icons.favorite
                                              : Icons.favorite_border_sharp,
                                          color: infavoriteList == true
                                              ? Colors.amber
                                              : Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                BlocBuilder<CartCubit, CartState>(
                                  builder: (context, state) {
                                    bool inWishList = context
                                        .read<CartCubit>()
                                        .isProductInCart(
                                            foundproduct[index].id);
                                    return Container(
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: const Text(
                                                  'Click ok button to add the Cart'),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const SizedBox(
                                                    child: Text("Cancel"),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    print(
                                                        "this is the inwhichList in cart :-$inWishList");
                                                    Navigator.pop(context);

                                                    context
                                                        .read<CartCubit>()
                                                        .addCartList(
                                                            product:
                                                                foundproduct[
                                                                    index]);
                                                  },
                                                  child: const SizedBox(
                                                    child: Text("okay"),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.add_shopping_cart,
                                            color: inWishList == true
                                                ? Colors.amber
                                                : Colors.black),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
