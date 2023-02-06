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
            crossAxisSpacing: 25,
            childAspectRatio: 0.6),
        delegate: SliverChildListDelegate(
          [
            ...contacts.map((contact) => SingleGridItem(
                  // imgUrl: contact.contact.imgUrl,
                  imgUrl: '',
                  title: contact.contact.displayName ?? '',
                  color:
                      // contact.contact.color ?? Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor,
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
