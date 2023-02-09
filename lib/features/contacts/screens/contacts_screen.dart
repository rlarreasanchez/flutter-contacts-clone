import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';

class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onAddContact() {
      Navigator.pushNamed(context, 'contact');
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffD3E3FD),
          child: const Icon(
            Icons.add,
            color: Color(0xff041E49),
          ),
          onPressed: () async {
            try {
              Contact newContact = await ContactsService.openContactForm();
              ContactModel newContactModel = ContactModel.fromMap(newContact);
              ref.read(contactsProvider.notifier).addContact(newContactModel);
              onAddContact();
            } catch (e) {
              inspect(e);
            }
          },
        ),
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: false,
          title: const ContactsSearchBar(),
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
        ),
        backgroundColor: Colors.white,
        body: Column(children: [
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
          Expanded(child: ContactsStickyList()),
        ]),
      ),
    );
  }
}
