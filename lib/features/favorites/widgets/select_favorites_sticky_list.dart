import 'package:contactos_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
import 'package:contactos_app/features/favorites/screens/select_favorites_screen.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/models/contact_list_item_model.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';

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
    final contactsRef = ref.watch(contactsProvider);

    List<ContactModel> filterContactList(List<ContactModel> contactos) {
      if (searchTerm.isEmpty) return [];
      return contactos
          .where((contacto) =>
              Utils.containsStringTerm(
                  contacto.displayName ?? '', searchTerm) ||
              Utils.containsListTerm(
                  contacto.emails!.map((email) => email.value ?? '').toList(),
                  searchTerm))
          .toList();
    }

    return isSearching && searchTerm.isNotEmpty
        ? CustomScrollView(
            controller: _controller,
            slivers: [
              ...generateContactsSlivers(
                  filterContactList(contactsRef.contacts), _controller, false)
            ],
          )
        : DraggableScrollbar(
            heightScrollThumb: 70.0,
            offsetHeight: 0,
            controller: _controller,
            contactsModels: ContactsUtils.getContactsStickyList(
                contactsRef.contacts, false),
            child: CustomScrollView(
              controller: _controller,
              slivers: [
                ...generateContactsSlivers(contactsRef.contacts, _controller)
              ],
            ),
          );
  }
}
