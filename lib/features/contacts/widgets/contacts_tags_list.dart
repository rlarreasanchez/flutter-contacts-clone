import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/features/contacts/provider/filter_contacts_provider.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';

class ContactsTagsList extends ConsumerWidget {
  const ContactsTagsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterContactsProvider);

    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        const SizedBox(
          width: 10.0,
        ),
        ContactsTag(
            icon: Icons.phone_outlined,
            title: 'Contactos telefónicos',
            active: filter.byPhone,
            onTap: () {
              if (filter.byPhone) {
                ref
                    .read(filterContactsProvider.notifier)
                    .deactiveFilterByPhone();
              } else {
                ref.read(filterContactsProvider.notifier).activeFilterByPhone();
              }
            }),
        ContactsTag(
          icon: Icons.mail_outline,
          title: 'Contactos de correo',
          active: filter.byEmail,
          onTap: () {
            if (filter.byEmail) {
              ref.read(filterContactsProvider.notifier).deactiveFilterByEmail();
            } else {
              ref.read(filterContactsProvider.notifier).activeFilterByEmail();
            }
          },
        ),
        ContactsTag(
          icon: Icons.business_outlined,
          title: 'Empresa',
          active: false,
          onTap: () {},
        ),
        const SizedBox(
          width: 10.0,
        ),
      ],
    );
  }
}
