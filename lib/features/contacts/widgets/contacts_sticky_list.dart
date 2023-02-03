import 'package:flutter/material.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:contactos_app/features/contacts/data/contacts_fake.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/models/contact_listItem_model.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';

class ContactsStickyList extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  ContactsStickyList({
    Key? key,
  }) : super(key: key);

  List<ContactsStickySliver> generateContactsSlivers(
      List<ContactModel> contactos, ScrollController controller) {
    final List<ContactListItemModel> contactosList =
        ContactsUtils.getContactsStickyList(contactos);

    return contactosList
        .asMap()
        .entries
        .map((contact) => ContactsStickySliver(
            index: contact.key,
            item: contact.value,
            scrollController: controller))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollbar(
      heightScrollThumb: 70.0,
      offsetHeight: 20,
      controller: _controller,
      contactsModels: ContactsUtils.getContactsStickyList(contactsFake),
      child: CustomScrollView(
        controller: _controller,
        slivers: [
          const _ContactsListHeader(
              mail: 'rlarreasanchez@gmail.com', nContacts: 175),
          ...generateContactsSlivers(contactsFake, _controller)
        ],
      ),
    );
  }
}

class _ContactsListHeader extends StatelessWidget {
  final String mail;
  final int nContacts;

  const _ContactsListHeader({
    Key? key,
    required this.mail,
    required this.nContacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        padding: const EdgeInsets.only(left: 25.0, bottom: 18, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.person_outline,
              size: 20,
              color: Colors.black87,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                '$mail · $nContacts contactos',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
