import 'package:add_to_cart/cubit/favorite_cubit.dart';
import 'package:add_to_cart/model/favorite_model.dart';
import 'package:add_to_cart/model/product_model.dart';
import 'package:add_to_cart/screen/favorite_list.dart';
import 'package:add_to_cart/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      ),
      body: ListView.builder(
        itemCount: Const.product.length,
        itemBuilder: (context, index) {
          return Card(
            child: Stack(
              children: [
                BlocBuilder<FavoriteCubit, FavoriteModel>(
                  builder: (context, state) {
                    bool inWishList = context
                        .read<FavoriteCubit>()
                        .inFavoriteList(Const.product[index]);
                    return ListTile(
                      leading: ClipOval(
                        child: CircleAvatar(
                          child: Image.network(
                            Const.product[index].pic.toString(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: Text(
                        Const.product[index].name.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Price :- ${Const.product[index].price}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
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

                                    context
                                        .read<FavoriteCubit>()
                                        .addFavoriteList(
                                            product: Const.product[index]);
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
                          inWishList == true
                              ? Icons.favorite
                              : Icons.favorite_border_sharp,
                          color:
                              inWishList == true ? Colors.amber : Colors.black,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
