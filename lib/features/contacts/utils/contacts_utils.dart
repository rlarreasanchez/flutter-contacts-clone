import 'package:contactos_app/constants/ui_constants.dart';
import 'package:contactos_app/features/contacts/models/contact_listItem_model.dart';
import 'package:contactos_app/shared/utils/utils.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/animation.dart';

class ContactsUtils {
  static List<ContactListItemModel> getContactsStickyList(
      List<Contact> contactos,
      [bool withFavorites = true]) {
    List<String> headers = [
      ...contactos
          .map((contacto) {
            if (contacto.displayName != null &&
                contacto.displayName!.isNotEmpty) {
              if (contacto.displayName![0] == '+') {
                return '#';
              }
              return removeDiacritics(contacto.displayName![0].toUpperCase());
            }

            return '#';
          })
          .toSet()
          .toList()
        ..sort()
    ];

    List<ContactListItemModel> contactsStickyList = headers
        .map((header) => ContactListItemModel(
            letter: header,
            contacts: contactos.where((contacto) {
              if (contacto.displayName != null &&
                  contacto.displayName!.isNotEmpty) {
                if (header == '#') {
                  return contacto.displayName![0] == '+';
                }
                return header ==
                    removeDiacritics(contacto.displayName![0].toUpperCase());
              }

              return false;
            }).toList()))
        .toList();

    //TODO: Obtener contactos favoritos
    return contactsStickyList;

    // if (!withFavorites) {
    //   return contactsStickyList;
    // }

    // List<Contact> favContacts =
    //     contactos.where((c) => c. ?? false).toList();

    // final ContactListItemModel favoritesItem =
    //     ContactListItemModel(contacts: favContacts, favorite: true);

    // return [favoritesItem, ...contactsStickyList];
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

  static Color getColor() {
    final int nColors = UiConstants.contactsColors.length;

    return UiConstants.contactsColors[Utils.getRandomInt(0, nColors)];
  }
}
