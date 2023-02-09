import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contact/screens/contact_screen.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';

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
    final contactsRef = ref.watch(contactsProvider);

    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: [
        _EditButton(contactRef: contactsRef.activeContact),
        _FavoriteButton(contact: contactsRef.activeContact),
        _DeleteButton(contact: contactsRef.activeContact),
      ],
      title: _ContactAppBarTitle(
          title: contactsRef.activeContact?.displayName ?? ''),
    );
  }
}

class _DeleteButton extends ConsumerWidget {
  const _DeleteButton({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final ContactModel? contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onDeleteContact() {
      Navigator.pop(context); //dismiss dialog
      Navigator.pop(context); //dismiss contact screen
      const snackBar = SnackBar(
        content: Text(
          'Contacto eliminado con éxito',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return IconButton(
      onPressed: () async {
        if (contact != null) {
          showDialog(
            context: context,
            useRootNavigator: false,
            builder: ((context) => AlertDialog(
                  title: const Text("Eliminar Contacto"),
                  content: const Text(
                      "Estás seguro que deseas eliminar el contacto?"),
                  actions: [
                    TextButton(
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text(
                        "Continuar",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () async {
                        try {
                          await ContactsService.deleteContact(contact!);
                          ref
                              .read(contactsProvider.notifier)
                              .deleteActiveContact(contact!);
                          onDeleteContact();
                        } catch (e) {
                          inspect(e);
                        }
                      },
                    ),
                  ],
                )),
          );
        }
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}

class _FavoriteButton extends ConsumerWidget {
  const _FavoriteButton({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final ContactModel? contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        if (contact != null) {
          ref.read(contactsProvider.notifier).toggleActiveContact();
        }
      },
      icon: (contact != null && contact!.isFavorite)
          ? const Icon(Icons.star)
          : const Icon(Icons.star_outline),
    );
  }
}

class _EditButton extends ConsumerWidget {
  const _EditButton({
    Key? key,
    required this.contactRef,
  }) : super(key: key);

  final ContactModel? contactRef;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        if (contactRef != null) {
          try {
            Contact updatedContact = await ContactsService.openExistingContact(
                contactRef!,
                androidLocalizedLabels: false);
            ContactModel updatedModel = ContactModel.fromMap(updatedContact);
            ref
                .read(contactsProvider.notifier)
                .updateActiveContact(updatedModel);
            ref.read(contactsProvider.notifier).setActiveAvatar();
          } catch (e) {
            inspect(e);
          }
        }
      },
      icon: const Icon(Icons.edit_outlined),
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
