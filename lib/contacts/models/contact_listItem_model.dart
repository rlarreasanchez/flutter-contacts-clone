import 'package:contactos_app/contacts/models/contact_model.dart';

class ContactListItemModel {
  final String? letter;
  final bool favorite;
  final List<ContactModel> contacts;

  ContactListItemModel({
    this.letter,
    this.favorite = false,
    required this.contacts,
  }) : super();
}
