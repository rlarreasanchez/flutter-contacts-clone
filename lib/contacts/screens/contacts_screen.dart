import 'package:flutter/material.dart';
import 'package:contactos_app/contacts/widgets/contacts_sticky_list.dart';
import 'package:contactos_app/contacts/widgets/contacts_search_bar.dart';
import 'package:contactos_app/contacts/widgets/contacts_tags_list.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: const [
        // Buscador
        ContactsSearchBar(),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 38,
          child: ContactsTagsList(),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(child: ContactsStickyList())
      ]),
    );
  }
}
