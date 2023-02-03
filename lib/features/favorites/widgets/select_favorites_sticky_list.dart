import 'package:flutter/material.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:contactos_app/features/contacts/data/contacts_fake.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/models/contact_listItem_model.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';

class SelectFavoritesStickyList extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  SelectFavoritesStickyList({
    Key? key,
  }) : super(key: key);

  List<ContactsStickySliver> generateContactsSlivers(
      List<ContactModel> contactos, ScrollController controller) {
    final List<ContactListItemModel> contactosList =
        ContactsUtils.getContactsStickyList(contactos, false);

    return contactosList
        .asMap()
        .entries
        .map((contact) => ContactsStickySliver(
            index: contact.key,
            item: contact.value,
            scrollController: controller,
            withFavorites: true))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollbar(
      heightScrollThumb: 70.0,
      offsetHeight: 0,
      controller: _controller,
      contactsModels: ContactsUtils.getContactsStickyList(contactsFake, false),
      child: CustomScrollView(
        controller: _controller,
        slivers: [...generateContactsSlivers(contactsFake, _controller)],
      ),
    );
  }
}
