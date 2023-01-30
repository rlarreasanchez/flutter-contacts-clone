import 'dart:developer';

import 'package:contactos_app/contacts/models/contact_listItem_model.dart';
import 'package:contactos_app/contacts/models/contact_model.dart';

class ContactsUtils {
  static List<ContactListItemModel> getContactsStickyList(
      List<ContactModel> contactos) {
    List<String> headers = [
      ...contactos.map((contacto) => contacto.name[0]).toSet().toList()..sort()
    ];

    List<ContactModel> favContacts =
        contactos.where((c) => c.favorite ?? false).toList();

    final ContactListItemModel favoritesItem =
        ContactListItemModel(contacts: favContacts, favorite: true);

    return [
      favoritesItem,
      ...headers
          .map((header) => ContactListItemModel(
              letter: header,
              contacts: contactos
                  .where((contacto) => header == contacto.name[0])
                  .toList()
                ..sort((a, b) => a.name.compareTo(b.name))))
          .toList()
    ];
  }

  static List<ContactListScrollModel> getScrollModelContacts(
      List<ContactListItemModel> contactosItems,
      double initOffset,
      double maxViewOffset,
      double itemHeight) {
    final List<ContactListScrollModel> contactosLetter = contactosItems
        .map((item) => ContactListScrollModel(
            letter: item.letter ?? '', startPosition: 0.0, endPosition: 0.0))
        .toList();

    double offset = initOffset;
    for (var i = 0; i < contactosLetter.length; i++) {
      contactosLetter[i].startPosition = offset;
      contactosLetter[i].endPosition =
          offset + (itemHeight * contactosItems[i].contacts.length);

      offset = contactosLetter[i].endPosition;
    }

    return contactosLetter;
  }

  static double getContactsHeight(
      List<ContactListItemModel> contactosItems, double viewScrollExtend) {
    int contactos = 0;
    for (var i = 0; i < contactosItems.length; i++) {
      contactos += contactosItems[i].contacts.length;
    }

    return viewScrollExtend / contactos;
  }

  static String getScrollbarLetter(
      List<ContactListScrollModel> contactsScrollModel, double viewOffset) {
    ContactListScrollModel firstModel = contactsScrollModel[0];
    if (viewOffset < firstModel.startPosition) {
      return '';
    }

    ContactListScrollModel lastModel =
        contactsScrollModel[contactsScrollModel.length - 1];
    if (viewOffset >= lastModel.endPosition) {
      return lastModel.letter;
    }
    ContactListScrollModel? contacto = contactsScrollModel.firstWhere(
        (contacto) =>
            contacto.startPosition <= viewOffset &&
            contacto.endPosition > viewOffset);
    return contacto.letter;
  }
}
