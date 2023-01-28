import 'package:contactos_app/contacts/models/contact_listItem_model.dart';
import 'package:contactos_app/contacts/models/contact_model.dart';

class ContactsUtils {
  static List<ContactListItemModel> getContactsStickyList(
      List<ContactModel> contactos) {
    List<String> headers = [
      ...contactos.map((contacto) => contacto.name).toList()..sort()
    ];
    return headers
        .map((header) => ContactListItemModel(
            letter: header,
            contacts: contactos
                .where((contacto) => header == contacto.name[0])
                .toList()))
        .toList();
  }
}
