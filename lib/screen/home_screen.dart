import 'package:add_to_cart/cubit/cart_cubit.dart';

import 'package:add_to_cart/cubit/favorite_cubit.dart';
import 'package:add_to_cart/cubit/filter_cubit.dart';
import 'package:add_to_cart/data/model/favorite_model.dart';
import 'package:add_to_cart/data/model/product_model.dart';
import 'package:add_to_cart/screen/add_cart_screen.dart';
import 'package:add_to_cart/screen/favorite_list_screen.dart';
import 'package:add_to_cart/data/repository/product_list.dart';
import 'package:add_to_cart/screen/product_details.dart';
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

  @override
  void initState() {
    foundproduct = Const.product;
    context.read<CartCubit>().fetchCartItems();
    super.initState();
  }

  void filterProductsByPrice(String enterkeyword) {
    List<ProductModel> resultproduct = [];
    if (enterkeyword.isEmpty) {
      resultproduct = Const.product;
    } else {
      resultproduct = Const.product
          .where((product) =>
              product.name.toLowerCase().contains(enterkeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundproduct = resultproduct;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Product List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteList(),
                ),
              );
            },
            icon: const Icon(Icons.favorite),
            color: Colors.amber,
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddCartScreen()));
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
                    onChanged: (value) {
                      foundproduct = context
                          .read<FilterCubit>()
                          .filterProductsByPrice(value);
                      foundproduct = state.serchproduct ?? [];
                      print("this is the foundproduct");
                      print(foundproduct);
                      setState(() {});
                    },
                    controller: searchc,
                    decoration: InputDecoration(
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
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: foundproduct.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productModel: foundproduct[index]),
                    ));
              } else if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productModel: foundproduct[index]),
                    ));
              } else if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productModel: foundproduct[index]),
                    ));
              } else if (index == 3) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productModel: foundproduct[index]),
                    ));
              } else if (index == 4) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productModel: foundproduct[index]),
                    ));
              } else if (index == 5) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productModel: foundproduct[index]),
                    ));
              } else if (index == 6) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productModel: foundproduct[index]),
                    ));
              } else if (index == 7) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productModel: foundproduct[index]),
                    ));
              } else if (index == 8) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productModel: foundproduct[index]),
                    ));
              } else if (index == 9) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productModel: foundproduct[index]),
                    ));
              }
            },
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Price :- ${foundproduct[index].price}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
                                                        foundproduct[index]);
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
                                .isProductInCart(foundproduct[index].id);
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
                                                        foundproduct[index]);
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
          );
        },
      ),
    );
  }
}
