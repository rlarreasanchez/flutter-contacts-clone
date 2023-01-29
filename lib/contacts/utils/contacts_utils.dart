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
}
