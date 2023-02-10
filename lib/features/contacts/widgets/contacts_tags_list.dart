import 'dart:developer';

import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/features/contacts/provider/filter_contacts_provider.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';

class ContactsTagsList extends ConsumerWidget {
  const ContactsTagsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterContactsProvider);
    final contacts = ref.watch(contactsProvider).contacts;

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
        (filter.company.isNotEmpty)
            ? ContactsTag(
                icon: Icons.business_outlined,
                title: filter.company,
                active: true,
                onTap: () {
                  ref
                      .read(filterContactsProvider.notifier)
                      .deactiveFilterCompany();
                },
              )
            : ContactsTag(
                icon: Icons.business_outlined,
                title: 'Empresa',
                active: false,
                isSelectable: true,
                onTap: () {
                  _showModalButton(context, contacts).then(
                    (selectedCompany) => {
                      if (selectedCompany != null)
                        {
                          ref
                              .read(filterContactsProvider.notifier)
                              .activeFilterCompany(selectedCompany)
                        }
                    },
                  );
                },
              ),
        const SizedBox(
          width: 10.0,
        ),
      ],
    );
  }

  Future<dynamic> _showModalButton(
      BuildContext context, List<ContactModel> contacts) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) {
        List<String> companies = [...contacts]
            .map((contact) => contact.company)
            .whereType<String>()
            .toSet()
            .toList();
        return SafeArea(
          child: CustomScrollView(slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              title: Text(
                'Seleccione una Empresa',
                style: TextStyle(fontSize: 18),
              ),
              floating: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return RadioListTile(
                  value: companies[index],
                  groupValue: '',
                  title: Text(
                    companies[index].toUpperCase().replaceAll(' ', '\u{000A0}'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onChanged: (val) {
                    Navigator.pop(context, val);
                  },
                );
              }, childCount: companies.length),
            ),
          ]),
        );
      },
    );
  }
}
