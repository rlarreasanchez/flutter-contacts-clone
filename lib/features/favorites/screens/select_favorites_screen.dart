import 'package:contactos_app/features/favorites/widgets/select_favorites_sticky_list.dart';
import 'package:flutter/material.dart';

class SelectFavoritesScreen extends StatelessWidget {
  const SelectFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          backgroundColor: const Color(0xffF2F5FB),
          appBar: AppBar(
            title: const Text(
              'Seleccionar contactos',
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Expanded(child: SelectFavoritesStickyList())],
            ),
          )),
    ]);
  }
}
