import 'package:add_to_cart/cubit/favorite_cubit.dart';
import 'package:add_to_cart/data/model/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favorite List"),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteStateInSuccess) {
            if (state.favoriteitem.isEmpty) {
              return const Center(
                child: Text("Favorite List is Emty"),
              );
            } else {
              return ListView.builder(
                itemCount: state.favoriteitem.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Stack(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.network(
                            height: 50,
                            width: 50,
                            state.favoriteitem[index].pic.toString(),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        title: Text(
                          state.favoriteitem[index].name.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Price :- ${state.favoriteitem[index].price.toString()}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                                          .read<FavoriteCubit>()
                                          .removeFavoriteList(
                                              product:
                                                  state.favoriteitem[index].id);
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
                            Icons.favorite,
                            color: Colors.amber,
                          ),
                        ),
                      )
                    ],
                  ));
                },
              );
            }
          }
          return const Center();
        },
      ),
    );
  }
}
