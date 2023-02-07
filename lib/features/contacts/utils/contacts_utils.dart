import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/animation.dart';
import 'package:diacritic/diacritic.dart';
import 'package:contactos_app/constants/ui_constants.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/models/contact_list_item_model.dart';

class ContactsUtils {
  static List<ContactListItemModel> getContactsStickyList(
      List<ContactModel> contactos,
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
            }).toList()
              ..sort((a, b) => a.displayName!.compareTo(b.displayName!))))
        .toList();

    if (!withFavorites) {
      return contactsStickyList;
    }

    List<ContactModel> favContacts = contactos
        .where((c) => c.isFavorite)
        .toList()
      ..sort((a, b) => a.displayName!.compareTo(b.displayName!));

    final ContactListItemModel favoritesItem =
        ContactListItemModel(contacts: favContacts, favorite: true);

    return [favoritesItem, ...contactsStickyList];
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

  static Color getColor(String seed) {
    final int nColors = UiConstants.contactsColors.length;
    final int seedInt = int.parse(seed);
    final int scale =
        (nColors * ((seedInt / nColors) - (seedInt / nColors).floor())).floor();

    return UiConstants.contactsColors[scale];
  }

  static Future<void> launchContactUrl(String urlEncoded) async {
    var url = Uri.parse(urlEncoded);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
