import 'package:flutter/material.dart';
import 'package:contactos_app/contacts/widgets/contacts_sticky_list.dart';
import 'package:contactos_app/contacts/widgets/contacts_search_bar.dart';
import 'package:contactos_app/contacts/widgets/contacts_tags_list.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          // Buscador
          const ContactsSearchBar(),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 38,
            child: ContactsTagsList(),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(child: ContactsStickyList())
        ]),
      ),
    );
  }
}
