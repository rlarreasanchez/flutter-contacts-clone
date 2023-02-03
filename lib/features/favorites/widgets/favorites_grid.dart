import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';
import 'package:contactos_app/main.dart';
import 'package:contactos_app/shared/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesGrid extends ConsumerWidget {
  final List<ContactItem> contacts;

  const FavoritesGrid({super.key, required this.contacts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 15,
            childAspectRatio: 0.5),
        delegate: SliverChildListDelegate(
          [
            ...contacts.map((contact) => SingleGridItem(
                  imgUrl: contact.contact.imgUrl,
                  title: contact.contact.name,
                  color:
                      contact.contact.color ?? Theme.of(context).primaryColor,
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 150), () {
                      ref.read(contactProvider.notifier).state =
                          contact.contact;
                      Navigator.pushNamed(context, 'contact',
                          arguments: contact);
                    });
                  },
                ))
          ],
        ));
  }
}
