import 'package:contactos_app/database/favorites_db.dart';
import 'package:contactos_app/shared/utils/utils.dart';
import 'package:hive/hive.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/animation.dart';

class ContactModel extends Contact {
  List<Item> emailsSanitized = [];
  List<Item> phonesSanitized = [];
  bool isFavorite = false;
  Color? color;
  String? whatsAppPhone;

  ContactModel.fromMap(Contact contact) {
    identifier = contact.identifier;
    displayName = contact.displayName;
    givenName = contact.givenName;
    middleName = contact.middleName;
    familyName = contact.familyName;
    prefix = contact.prefix;
    suffix = contact.suffix;
    company = contact.company;
    jobTitle = contact.jobTitle;
    androidAccountTypeRaw = contact.androidAccountTypeRaw;
    androidAccountType = contact.androidAccountType;
    androidAccountName = contact.androidAccountName;
    emails = contact.emails;
    phones = contact.phones;
    postalAddresses = contact.postalAddresses;
    avatar = contact.avatar;
    birthday = contact.birthday;

    emailsSanitized = sanitizeItems(contact.emails ?? []);
    phonesSanitized = sanitizeItems((contact.phones ?? []).map((phone) {
      phone.value = Utils.stringToPhoneNumber(phone.value ?? '');
      return phone;
    }).toList());

    isFavorite = checkIfIsFavorite();
    if (phonesSanitized.isNotEmpty && androidAccountName == 'WhatsApp') {
      whatsAppPhone = getWhatsappPhone(phonesSanitized);
    }
  }

  List<Item> sanitizeItems(List<Item> items) {
    if (items.isNotEmpty) {
      var seen = <String>{};
      return items.where((item) => seen.add(item.value ?? '')).toList();
    }

    return [];
  }

  bool checkIfIsFavorite() {
    var myFavorites = Hive.box('myFavorites');
    var favorites = myFavorites.get('favorites');
    if (favorites != null) {
      List<String> favoritesList = favorites ?? [];
      if (favoritesList.contains(identifier)) {
        return true;
      }
    }

    return false;
  }

  void toggleFavorite() {
    FavoritesDb favoriteDb = FavoritesDb();
    isFavorite = !isFavorite;
    if (!isFavorite) {
      favoriteDb.removeFavorite(identifier ?? '');
    } else {
      favoriteDb.addFavorite(identifier ?? '');
    }
  }

  String? getWhatsappPhone(List<Item> phones) {
    if (phones.where((phone) => phone.label == 'móvil').isNotEmpty) {
      String? phoneString =
          phones.firstWhere((phone) => phone.label == 'móvil').value;
      if (phoneString!.contains('+34')) {
        return phoneString;
      }
      return '+34 $phoneString';
    }

    return null;
  }
}
