import 'package:contactos_app/contacts/data/contacts_fake.dart';
import 'package:contactos_app/contacts/models/contact_listItem_model.dart';
import 'package:contactos_app/contacts/models/contact_model.dart';
import 'package:contactos_app/contacts/utils/contacts_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class ContactsStickyList extends StatelessWidget {
  const ContactsStickyList({
    Key? key,
  }) : super(key: key);

  List<ContactsStickySliver> generateContactsSlivers(
      List<ContactModel> contactos) {
    final List<ContactListItemModel> contactosList =
        ContactsUtils.getContactsStickyList(contactos);

    return contactosList
        .asMap()
        .entries
        .map((contact) => ContactsStickySliver(
              index: contact.key,
              item: contact.value,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _ContactsListHeader(
            mail: 'rlarreasanchez@gmail.com', nContacts: 175),
        ...generateContactsSlivers(contactsFake)
      ],
    );
  }
}

class ContactsStickySliver extends StatelessWidget {
  const ContactsStickySliver({
    Key? key,
    this.index,
    required this.item,
  }) : super(key: key);

  final int? index;
  final ContactListItemModel item;

  @override
  Widget build(BuildContext context) {
    List<_ContactItem> generateContactList(List<ContactModel> contactos) {
      return contactos
          .map((contacto) => _ContactItem(
                contact: contacto,
              ))
          .toList();
    }

    return SliverStickyHeader(
      overlapsContent: true,
      header: _SideHeader(
          index: index, letter: item.letter ?? 'A', favorite: item.favorite),
      sliver: SliverPadding(
          padding: const EdgeInsets.only(left: 60),
          sliver: SliverToBoxAdapter(
              child: Column(
            children: [...generateContactList(item.contacts)],
          ))),
    );
  }
}

class _SideHeader extends StatelessWidget {
  const _SideHeader({
    Key? key,
    this.index,
    required this.letter,
    required this.favorite,
  }) : super(key: key);

  final int? index;
  final String letter;
  final bool favorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: (favorite)
            ? const Icon(
                Icons.star,
                color: Colors.blue,
                size: 25,
              )
            : Text(letter.toUpperCase(),
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500)),
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

class _ContactItem extends StatelessWidget {
  const _ContactItem({Key? key, required this.contact}) : super(key: key);

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: CircleAvatar(
            backgroundImage: NetworkImage(contact.imgUrl),
            backgroundColor: Colors.transparent,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              contact.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}
