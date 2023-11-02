import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:contactos_app/features/favorites/screens/select_favorites_screen.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';
import 'package:contactos_app/features/favorites/widgets/favorites_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsRef = ref.watch(contactsProvider);
    List<ContactItem> getFavorites(List<ContactModel> contactos) {
      return contactos
          .where((contacto) => contacto.isFavorite)
          .map((c) => ContactItem(
                contact: c,
              ))
          .toList()
        ..sort(
            (a, b) => a.contact.displayName!.compareTo(b.contact.displayName!));
    }

    List<ContactItem> favorites = getFavorites(contactsRef.contacts);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(children: [
            // Buscador
            const FavoritesSearchBar(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: CustomScrollView(slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate(
                [
                  const _FavoritesTitleAction(),
                  if (favorites.isEmpty) const FavoritesEmptyContainer(),
                ],
              )),
              FavoritesGrid(contacts: favorites),
            ]))
          ]),
        ),
      ),
    );
  }
}

class _FavoritesTitleAction extends StatelessWidget {
  const _FavoritesTitleAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Favoritos',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return const SelectFavoritesScreen();
                  },
                ),
              );
            },
            style: ButtonStyle(
              overlayColor: MaterialStatePropertyAll(Colors.grey[400]),
            ),
            child: Text(
              'Añadir',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 14),
            )),
      ],
    );
  }
}
