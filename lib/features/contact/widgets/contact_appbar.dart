import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:contactos_app/features/contact/providers/contact_provider.dart';
import 'package:contactos_app/features/contact/screens/contact_screen.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final ScrollController controller;

  const ContactAppBar({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactRef = ref.watch(contactProvider);

    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: [
        const Icon(Icons.edit_outlined),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            contactRef.toggleFavorite();
            ref.read(contactProvider.notifier).setContact(contactRef);
            ref.read(contactsProvider.notifier).updateContact(contactRef);
          },
          child: (contactRef!.isFavorite)
              ? const Icon(Icons.star)
              : const Icon(Icons.star_outline),
        ),
        const SizedBox(
          width: 20,
        ),
        const Icon(Icons.more_vert),
        const SizedBox(
          width: 20,
        ),
      ],
      title: _ContactAppBarTitle(title: contactRef.displayName ?? ''),
    );
  }
}

class _ContactAppBarTitle extends ConsumerWidget {
  const _ContactAppBarTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showTitle = ref.watch(showAppbarTitle);

    return (showTitle)
        ? FadeIn(
            duration: const Duration(milliseconds: 400),
            child: Text(
              title.replaceAll(' ', '\u{000A0}'),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: Colors.black),
            ),
          )
        : const SizedBox();
  }
}
