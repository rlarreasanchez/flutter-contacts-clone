import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';

@immutable
class ContactsState {
  const ContactsState(
      {required this.errorMessage,
      required this.loading,
      required this.contacts,
      required this.activeContact});

  final List<ContactModel> contacts;
  final String errorMessage;
  final bool loading;
  final ContactModel? activeContact;

  ContactsState copyWith(
      {List<ContactModel>? contacts,
      String? error,
      bool? loading,
      ContactModel? activeContact,
      bool clearActiveContact = false}) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      errorMessage: error ?? errorMessage,
      loading: loading ?? this.loading,
      activeContact: clearActiveContact == true
          ? null
          : activeContact ?? this.activeContact,
    );
  }
}

class ContactsNotifier extends StateNotifier<ContactsState> {
  ContactsNotifier(this.ref)
      : super(const ContactsState(
            errorMessage: '',
            loading: false,
            contacts: [],
            activeContact: null));
  final Ref ref;

  void getContacts() async {
    state = state.copyWith(loading: true);
    try {
      final List<Contact> contacts = await ContactsService.getContacts(
          withThumbnails: false, photoHighResolution: false);

      final List<ContactModel> contactsModel =
          contacts.map((contact) => ContactModel.fromMap(contact)).toList();

      state = state
          .copyWith(contacts: [...contactsModel], loading: false, error: '');
      getAvatars();
    } catch (e) {
      inspect(e);
      state = state.copyWith(
          contacts: [],
          loading: false,
          error: 'Fallo al cargar la lista de Contactos');
    }
  }

  void getAvatars() async {
    List<ContactModel> contacts = [...state.contacts];
    for (var contact in contacts) {
      Uint8List? avatar =
          await ContactsService.getAvatar(contact, photoHighRes: false);
      if (avatar != null && avatar.isNotEmpty) {
        ContactModel updatedContact = contact.copyWith(newAvatar: avatar);
        updateContact(updatedContact);
      }
    }
  }

  void addContact(ContactModel contact) {
    ContactModel newContact = contact.copyWith();
    state = state.copyWith(
        contacts: [...state.contacts, newContact], activeContact: newContact);
  }

  void setActiveContact(ContactModel? contact) {
    if (contact != null) {
      state = state.copyWith(activeContact: contact.copyWith());
    } else {
      state = state.copyWith(clearActiveContact: true);
    }
  }

  void toggleActiveContact() {
    if (state.activeContact != null) {
      ContactModel activeContact = state.activeContact!.copyWith()
        ..toggleFavorite();
      List<ContactModel> contacts = [...state.contacts];
      List<ContactModel> restContacts = contacts
          .where((c) => c.identifier != state.activeContact!.identifier)
          .toList();
      state = state.copyWith(contacts: [...restContacts, activeContact]);
    }
  }

  void setActiveAvatar([bool refresh = false]) async {
    if (state.activeContact != null) {
      if (!refresh && state.activeContact!.highImageLoaded) {
        return;
      }
      try {
        Uint8List? avatar =
            await ContactsService.getAvatar(state.activeContact!);
        if (avatar != null && avatar.isNotEmpty) {
          ContactModel activeContactUpdated = state.activeContact!
              .copyWith(newAvatar: avatar, highImageLoaded: true);
          updateActiveContact(activeContactUpdated);
        }
      } catch (e) {
        inspect(e);
      }
    }
  }

  void updateActiveContact(ContactModel contact) {
    List<ContactModel> contacts = [...state.contacts];
    List<ContactModel> restContacts =
        contacts.where((c) => c.identifier != contact.identifier).toList();
    state = state.copyWith(
        contacts: [...restContacts, contact.copyWith()],
        activeContact: contact.copyWith());
  }

  void updateContact(ContactModel contact) {
    List<ContactModel> contacts = [...state.contacts];
    List<ContactModel> restContacts =
        contacts.where((c) => c.identifier != contact.identifier).toList();
    state = state.copyWith(contacts: [...restContacts, contact.copyWith()]);
  }

  void deleteActiveContact(ContactModel contact) {
    List<ContactModel> contacts = [...state.contacts];
    List<ContactModel> restContacts =
        contacts.where((c) => c.identifier != contact.identifier).toList();
    state =
        state.copyWith(contacts: [...restContacts], clearActiveContact: true);
  }
}

final contactsProvider =
    StateNotifierProvider<ContactsNotifier, ContactsState>((ref) {
  return ContactsNotifier(ref);
});
