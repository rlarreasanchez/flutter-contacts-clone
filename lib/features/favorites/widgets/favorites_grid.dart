import 'package:contactos_app/features/contact/providers/contact_provider.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';
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
            crossAxisSpacing: 10,
            childAspectRatio: 0.7),
        delegate: SliverChildListDelegate(
          [
            ...contacts.map((contact) => SingleGridItem(
                  header: ContactAvatarItem(
                    contact: contact.contact,
                    radius: 30,
                  ),
                  title: contact.contact.displayName ?? '',
                  color:
                      ContactsUtils.getColor(contact.contact.identifier ?? '0'),
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 150), () {
                      ref
                          .read(contactProvider.notifier)
                          .setContact(contact.contact);
                      Navigator.pushNamed(context, 'contact',
                          arguments: contact);
                    });
                  },
                ))
          ],
        ));
  }
}
