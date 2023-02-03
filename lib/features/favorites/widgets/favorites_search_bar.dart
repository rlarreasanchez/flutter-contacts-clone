import 'package:flutter/material.dart';
import 'package:contactos_app/features/contacts/screens/search_screen.dart';
import 'package:contactos_app/shared/widgets/search_bar.dart';

class FavoritesSearchBar extends StatelessWidget {
  const FavoritesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SearchBar(
        hintText: 'Buscar contactos',
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return const SearchScreen();
              },
            ),
          );
        },
        startIcon: Icons.search_outlined,
      ),
    );
  }
}
