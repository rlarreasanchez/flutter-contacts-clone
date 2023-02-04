import 'package:contactos_app/features/favorites/screens/select_favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:contactos_app/features/contacts/data/contacts_fake.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/models/contact_listItem_model.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectFavoritesStickyList extends ConsumerWidget {
  final ScrollController _controller = ScrollController();

  SelectFavoritesStickyList({
    Key? key,
  }) : super(key: key);

  List<ContactsStickySliver> generateContactsSlivers(
      List<ContactModel> contactos, ScrollController controller,
      [bool withHeaders = true]) {
    final List<ContactListItemModel> contactosList =
        ContactsUtils.getContactsStickyList(contactos, false);

    return contactosList
        .asMap()
        .entries
        .map((contact) => ContactsStickySliver(
              index: contact.key,
              item: contact.value,
              scrollController: controller,
              withFavorites: true,
              withHeaders: withHeaders,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider);
    final searchTerm = ref.watch(favoriteTermProvider);

    List<ContactModel> filterContactList(List<ContactModel> contactos) {
      if (searchTerm.isEmpty) return [];
      return contactos
          .where((contacto) =>
              contacto.containsTermByName(searchTerm) ||
              contacto.containsTermByEmail(searchTerm))
          .toList();
    }

    return isSearching && searchTerm.isNotEmpty
        ? CustomScrollView(
            controller: _controller,
            slivers: [
              ...generateContactsSlivers(
                  filterContactList(contactsFake), _controller, false)
            ],
          )
        : DraggableScrollbar(
            heightScrollThumb: 70.0,
            offsetHeight: 0,
            controller: _controller,
            contactsModels:
                ContactsUtils.getContactsStickyList(contactsFake, false),
            child: CustomScrollView(
              controller: _controller,
              slivers: [...generateContactsSlivers(contactsFake, _controller)],
            ),
          );
  }
}
