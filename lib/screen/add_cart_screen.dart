import 'package:add_to_cart/cubit/cart_cubit.dart';
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
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInSuccess) {
            if (state.cartitem.isEmpty) {
              return const Center(child: Text("Cart is Emty"));
            } else {
              return ListView.builder(
                itemCount: state.cartitem.length,
                itemBuilder: (context, index) {
                  final cartItem = state.cartitem[index];
                  int counter = state.cartitem[index].qty;
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
                                  state.cartitem[index].pic.toString(),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              title: Text(
                                state.cartitem[index].name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Price :- ${state.cartitem[index].price.toString()}",
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
                                            context
                                                .read<CartCubit>()
                                                .removeFromCart(
                                                    cartItemId: cartItem.id);
                                            print('remove..............');

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
                              child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<CartCubit>()
                                        .decreaseQuantityOfCartItem(
                                            cartItem.id);
                                  },
                                  icon:
                                      const Icon(Icons.remove_circle_outline)),
                            ),
                            Positioned(
                              bottom: BorderSide.strokeAlignCenter,
                              left: 103,
                              top: 65,
                              child: Text(
                                cartItem.qty.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            Positioned(
                              bottom: BorderSide.strokeAlignCenter,
                              left: 110,
                              child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<CartCubit>()
                                        .increceQuantityOfCartItem(
                                            productId: cartItem.id);
                                    print("this is the qty: -");
                                    print(cartItem.qty);
                                  },
                                  icon: const Icon(Icons.add_circle_outline)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
          if (state is CartInerror) {
            return Text(state.error);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInSuccess) {
            if (state.cartitem.isEmpty) {
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
                                itemCount: state.cartitem.length,
                                itemBuilder: (context, index) {
                                  var name = state.cartitem[index].name;
                                  var price = state.cartitem[index].price;
                                  var qty = state.cartitem[index].qty;
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
                              BlocBuilder<CartCubit, CartState>(
                                builder: (context, state) {
                                  double totalamount =
                                      context.read<CartCubit>().totalAmount();

                                  return Column(
                                    children: [
                                      Text(
                                        "Total Amount :- $totalamount",
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          context.read<CartCubit>().pdf();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  backgroundColor:
                                                      Colors.purpleAccent,
                                                  content: Text(
                                                      "Pdf Download Successfully")));
                                        },
                                        child: const Text("Pay",
                                            style: TextStyle(fontSize: 20)),
                                      )
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
          } else if (state is CartInerror) {
            return Text("This is Error :- ${state.error}");
          }
          return Container();
        },
      ),
    );
  }
}
