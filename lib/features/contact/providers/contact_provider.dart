import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';

class ContactNotifier extends StateNotifier<ContactModel?> {
  ContactNotifier() : super(null);

  void setContact(ContactModel contact) {
    state = ContactModel.fromMap(contact);
  }
}

final contactProvider =
    StateNotifierProvider<ContactNotifier, ContactModel?>((ref) {
  return ContactNotifier();
});
