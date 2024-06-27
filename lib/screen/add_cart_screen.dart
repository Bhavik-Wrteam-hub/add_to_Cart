import 'package:add_to_cart/cubit/cart_cubit.dart';
import 'package:add_to_cart/cubit/count_cubit.dart';
import 'package:add_to_cart/cubit/favorite_cubit.dart';
import 'package:add_to_cart/model/cart_model.dart';
import 'package:add_to_cart/model/favorite_model.dart';
import 'package:add_to_cart/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCartScreen extends StatefulWidget {
  const AddCartScreen({super.key});

  @override
  State<AddCartScreen> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<AddCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cart List"),
       
      ),
      body: BlocBuilder<CounterCubit, ProductModel>(
        builder: (context, state) {
          return BlocBuilder<CartCubit, CartModel>(
            builder: (context, state) {
              if (state.product!.isEmpty) {
                return const Center(
                  child: Text(
                    'No items in Cart List',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.product!.length,
                  itemBuilder: (context, index) {
                    int counter = state.product![index].count;
                    print("Counter");
                    print(counter);
                    return Card(
                        child: Column(
                      children: [
                        Stack(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: Image.network(
                                  height: 50,
                                  width: 50,
                                  state.product![index].pic.toString(),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              title: Text(
                                state.product![index].name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Price :- ${state.product![index].price.toString()}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: const Text(
                                          'Click ok button to Remove the favorite'),
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
                                            print('remove..............');
                                            context
                                                .read<CartCubit>()
                                                .removeCartList(
                                                    product:
                                                        state.product![index]);
                                            Navigator.pop(context);
                                          },
                                          child: const SizedBox(
                                            child: Text("okay"),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove_shopping_cart_outlined,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            Positioned(
                              bottom: BorderSide.strokeAlignCenter,
                              left: 55,
                              child: TextButton(
                                onPressed: () {
                                  context
                                      .read<CounterCubit>()
                                      .conterDecrement(state.product![index]);
                                },
                                child: const Text(
                                  "-",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: BorderSide.strokeAlignCenter,
                              left: 110,
                              top: 65,
                              child: Text(
                                "$counter",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            Positioned(
                              bottom: BorderSide.strokeAlignCenter,
                              left: 110,
                              child: TextButton(
                                onPressed: () {
                                  context
                                      .read<CounterCubit>()
                                      .conterIncrement(state.product![index]);
                                },
                                child: const Text("+",
                                    style: TextStyle(
                                      fontSize: 25,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
                  },
                );
              }
            },
          );
        },
      ),
      floatingActionButton: BlocBuilder<CartCubit, CartModel>(
        builder: (context, state) {
          if (state.product!.isEmpty) {
            return Container();
          } else {
            return FloatingActionButton(
              child: const Icon(Icons.paypal_rounded),
              onPressed: () {
                // context.read<CartCubit>().totalAmount(total_amount: total);
                showBottomSheet(
                  backgroundColor: const Color.fromARGB(255, 155, 195, 238),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  context: context,
                  builder: (context) {
                    var total = 0;
                    return Column(
                      children: [
                        Container(
                          color: Colors.amber,
                          height: 550,
                          child: Center(
                            child: ListView.builder(
                              itemCount: state.product!.length,
                              itemBuilder: (context, index) {
                                var name = state.product![index].name as String;
                                var price = state.product![index].price as int;
                                var qty = state.product![index].count;
                                var subTotal = price * qty;
                                total += (price * qty);

                                print(total);
                                return Builder(
                                  builder: (context) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text("Product Name :- $name"),
                                          Text("Product Price :- $price"),
                                          Text("Product Quantity :- $qty"),
                                          Text("Total :- $subTotal"),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            BlocBuilder<CartCubit, CartModel>(
                              builder: (context, state) {
                                int totalamount =
                                    context.read<CartCubit>().totalAmount();

                                return Column(
                                  children: [
                                    Text(
                                      "Total Amount :- $totalamount",
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
