import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';

class ContactNotifier extends StateNotifier<ContactModel?> {
  ContactNotifier() : super(null);

  void setContact(ContactModel contact) {
    state = ContactModel.fromMap(contact);
  }

  void setAvatar() async {
    if (state == null) {
      return;
    }
    Uint8List? avatar = await ContactsService.getAvatar(state!);
    ContactModel newContact = ContactModel.fromMap(state!);
    newContact.avatar = avatar;
    state = newContact;
  }

  void deleteContact() {
    state = null;
  }
}

final contactProvider =
    StateNotifierProvider<ContactNotifier, ContactModel?>((ref) {
  return ContactNotifier();
});
