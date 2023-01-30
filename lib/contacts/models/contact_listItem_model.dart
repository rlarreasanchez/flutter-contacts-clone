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

class ContactListScrollModel {
  final String letter;
  double startPosition;
  double endPosition;

  ContactListScrollModel(
      {required this.letter,
      required this.startPosition,
      required this.endPosition});
}
