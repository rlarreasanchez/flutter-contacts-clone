import 'package:contactos_app/features/favorites/screens/select_favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/data/contacts_fake.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';
import 'package:contactos_app/features/favorites/widgets/favorites_widgets.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ContactItem> getFavorites(List<ContactModel> contactos) {
      return contactos
          .where((contacto) => contacto.favorite ?? false)
          .map((c) => ContactItem(
                contact: c,
              ))
          .toList();
    }

    List<ContactItem> favorites = getFavorites(contactsFake);

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
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(
                  height: 20,
                ),
                const _RecientesTitleAction(),
                const SizedBox(
                  height: 10,
                ),
                const RecientesCardContainer(),
                const SizedBox(
                  height: 20,
                ),
              ]))
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
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
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
                  color: Theme.of(context).primaryColor, fontSize: 16),
            )),
      ],
    );
  }
}

class _RecientesTitleAction extends StatelessWidget {
  const _RecientesTitleAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Recientes',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(Icons.more_vert),
        )
      ],
    );
  }
}
