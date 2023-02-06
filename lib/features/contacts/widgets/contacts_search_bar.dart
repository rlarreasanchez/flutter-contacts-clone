import 'package:contactos_app/shared/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:contactos_app/features/contacts/screens/search_screen.dart';

class ContactsSearchBar extends StatelessWidget {
  const ContactsSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchBar(
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
        startIcon: Icons.menu,
        hintText: 'Buscar contactos');
  }
}
