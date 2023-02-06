import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactListItemModel {
  final String? letter;
  final bool favorite;
  final List<Contact> contacts;

  ContactListItemModel({
    this.letter,
    this.favorite = false,
    required this.contacts,
  }) : super();
}

class ContactListScrollModel {
  final String letter;
  double startPosition;
  double endPosition;

  ContactListScrollModel(
      {required this.letter,
      required this.startPosition,
      required this.endPosition});
}
