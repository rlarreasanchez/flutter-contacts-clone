import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/models/contact_list_item_model.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';

class ContactsStickySliver extends StatelessWidget {
  const ContactsStickySliver({
    Key? key,
    this.index,
    required this.scrollController,
    required this.item,
    this.withFavorites = false,
    this.withHeaders = true,
  }) : super(key: key);

  final int? index;
  final ContactListItemModel item;
  final ScrollController scrollController;
  final bool withFavorites;
  final bool withHeaders;

  @override
  Widget build(BuildContext context) {
    List<Widget> generateContactList(List<ContactModel> contactos) {
      return contactos
          .map((contacto) => FadeIn(
                child: ContactItem(
                  contact: contacto,
                  withFavIcon: withFavorites,
                ),
              ))
          .toList();
    }

    return SliverStickyHeader(
      overlapsContent: true,
      header: (withHeaders)
          ? _SideHeader(
              index: index, letter: item.letter ?? '', favorite: item.favorite)
          : const SizedBox(),
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
      padding: (favorite)
          ? const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0)
          : const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: (favorite)
            ? Icon(
                Icons.star,
                color: Theme.of(context).primaryColor,
                size: 25,
              )
            : Text(letter.toUpperCase(),
                style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500)),
      ),
    );
  }
}
