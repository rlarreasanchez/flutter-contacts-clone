import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class ContactsStickyList extends StatelessWidget {
  const ContactsStickyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        _ContactsListHeader(mail: 'rlarreasanchez@gmail.com', nContacts: 175),
        _ContactsStickySliver(index: 0),
        _ContactsStickySliver(index: 1),
        _ContactsStickySliver(index: 2),
        _ContactsStickySliver(index: 3),
      ],
    );
  }
}

class _ContactsStickySliver extends StatelessWidget {
  const _ContactsStickySliver({
    Key? key,
    this.index,
  }) : super(key: key);

  final int? index;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      overlapsContent: true,
      header: _SideHeader(index: index),
      sliver: SliverPadding(
          padding: const EdgeInsets.only(left: 60),
          sliver: SliverToBoxAdapter(
              child: Column(
            children: const [
              _ContactItem(),
              _ContactItem(),
              _ContactItem(),
              _ContactItem(),
              _ContactItem()
            ],
          ))),
    );
  }
}

class _SideHeader extends StatelessWidget {
  const _SideHeader({
    Key? key,
    this.index,
  }) : super(key: key);

  final int? index;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 44.0,
          width: 44.0,
          child: Icon(
            Icons.star,
            color: Colors.blue,
            size: 25,
          ),
        ),
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

class ContactsList extends StatelessWidget {
  const ContactsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        _ContactsListItem(),
        _ContactsListItem(),
        _ContactsListItem(),
        _ContactsListItem(),
        _ContactsListItem(),
      ],
    );
  }
}

class _ContactsListItem extends StatelessWidget {
  const _ContactsListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Icon(
            Icons.star,
            color: Colors.blue,
            size: 25,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: const [
              _ContactItem(),
              _ContactItem(),
              _ContactItem(),
              _ContactItem(),
              _ContactItem(),
              _ContactItem(),
              _ContactItem(),
            ],
          ),
        )
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: CircleAvatar(),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Antonio Estevez de la Osa Mayor y todos los santos',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        )
      ],
    );
  }
}
