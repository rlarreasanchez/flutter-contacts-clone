import 'dart:developer';

import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class ContactsState {
  const ContactsState(
      {required this.errorMessage,
      required this.loading,
      required this.contacts});

  final List<ContactModel> contacts;
  final String errorMessage;
  final bool loading;

  ContactsState copyWith(
      {List<ContactModel>? contacts, String? error, bool? loading}) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      errorMessage: error ?? errorMessage,
      loading: loading ?? this.loading,
    );
  }
}

class ContactsNotifier extends StateNotifier<ContactsState> {
  ContactsNotifier()
      : super(const ContactsState(
            errorMessage: '', loading: false, contacts: []));

  void getContacts() async {
    state = state.copyWith(loading: true);
    try {
      final List<Contact> contacts = await ContactsService.getContacts(
          withThumbnails: false, photoHighResolution: false);

      final List<ContactModel> contactsModel =
          contacts.map((contact) => ContactModel.fromMap(contact)).toList();

      state =
          state.copyWith(contacts: contactsModel, loading: false, error: '');
    } catch (e) {
      inspect(e);
      state = state.copyWith(
          contacts: [],
          loading: false,
          error: 'Fallo al cargar la lista de Contactos');
    }
  }

  updateContact(ContactModel contact) {
    List<ContactModel> contacts = state.contacts;
    List<ContactModel> restContacts =
        contacts.where((c) => c.identifier != contact.identifier).toList();
    state = state.copyWith(contacts: [...restContacts, contact]);
  }

  deleteContact(ContactModel contact) {
    List<ContactModel> contacts = state.contacts;
    List<ContactModel> restContacts =
        contacts.where((c) => c.identifier != contact.identifier).toList();
    state = state.copyWith(contacts: [...restContacts]);
  }
}

final contactsProvider =
    StateNotifierProvider<ContactsNotifier, ContactsState>((ref) {
  return ContactsNotifier();
});
