import 'package:add_to_cart/cubit/cart_cubit.dart';
import 'package:add_to_cart/cubit/favorite_cubit.dart';
import 'package:add_to_cart/cubit/rating_cubit.dart';
import 'package:add_to_cart/data/model/favorite_model.dart';
import 'package:add_to_cart/data/model/product_model.dart';
import 'package:add_to_cart/screen/add_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    ProductModel productModel = arguments['productModel'];

    print("Product name");
    print(productModel.name);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(productModel.pic),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50, left: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(2, 1),
                                        color:
                                            Color.fromARGB(255, 156, 154, 154),
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Color.fromARGB(255, 247, 245, 238),
                                  ),
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 50, right: 10),
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(2, 1),
                                              color: Color.fromARGB(
                                                  255, 156, 154, 154),
                                              blurRadius: 2.0)
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                            Color.fromARGB(255, 247, 245, 238),
                                      ),
                                      child: BlocBuilder<FavoriteCubit,
                                          FavoriteModel>(
                                        builder: (context, state) {
                                          final inFavorite = context
                                              .read<FavoriteCubit>()
                                              .inFavoriteList;
                                          return InkWell(
                                            onTap: () {
                                              context
                                                  .read<FavoriteCubit>()
                                                  .addFavoriteList(
                                                      product: productModel);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor:
                                                      Colors.white38,
                                                  content: Text(
                                                    "SuccessFully Add In Favorite",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Icon(
                                              Icons.favorite_border,
                                              color: inFavorite == true
                                                  ? Colors.amber
                                                  : Colors.black,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(2, 1),
                                              color: Color.fromARGB(
                                                  255, 156, 154, 154),
                                              blurRadius: 2.0)
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                            Color.fromARGB(255, 247, 245, 238),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddCartScreen(),
                                              ));
                                        },
                                        child: const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                productModel.name,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "\$${productModel.price.toString()} ",
                style: const TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
            ),
          ),
          BlocBuilder<RatingCubit, RatingState>(
            builder: (context, state) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: PannableRatingBar(
                        rate: rating,
                        items: List.generate(
                            5,
                            (index) => const RatingWidget(
                                  selectedColor: Colors.yellow,
                                  unSelectedColor: Colors.grey,
                                  child: Icon(
                                    Icons.star,
                                    size: 40,
                                  ),
                                )),
                        onChanged: (value) {
                          rating =
                              context.read<RatingCubit>().rating(rate: value);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(rating.toString())
                ],
              );
            },
          )
        ],
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return BottomAppBar(
            padding: const EdgeInsets.all(20),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      if (state is CartInSuccess) {
                        context
                            .read<CartCubit>()
                            .addCartList(product: productModel);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCartScreen(),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.shopping_cart_checkout_rounded,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (state is CartInSuccess) {
                        context
                            .read<CartCubit>()
                            .addCartList(product: productModel);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCartScreen(),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.paypal_rounded,
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
