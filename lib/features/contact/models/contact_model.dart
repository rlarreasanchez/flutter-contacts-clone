import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:contactos_app/database/favorites_db.dart';
import 'package:contactos_app/shared/utils/utils.dart';

class ContactModel extends Contact {
  String? id;
  bool highImageLoaded = false;

  ContactModel({
    id,
    this.highImageLoaded = false,
    super.displayName,
    super.givenName,
    super.middleName,
    super.prefix,
    super.suffix,
    super.familyName,
    super.company,
    super.jobTitle,
    super.emails,
    super.phones,
    super.postalAddresses,
    super.avatar,
    super.birthday,
    super.androidAccountType,
    super.androidAccountTypeRaw,
    super.androidAccountName,
  }) : super() {
    identifier = id;
  }

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
  }

  Color get color {
    return ContactsUtils.getColor(identifier ?? '0');
  }

  bool get isFavorite {
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

  List<Item> get emailsSanitized {
    return sanitizeItems(emails ?? []);
  }

  List<Item> get phonesSanitized {
    return sanitizeItems((phones ?? []).map((phone) {
      phone.value = Utils.stringToPhoneNumber(phone.value ?? '');
      return phone;
    }).toList());
  }

  String? get whatsAppPhone {
    if (phones != null &&
        phones!.where((phone) => phone.label == 'móvil').isNotEmpty) {
      String? phoneString =
          phones!.firstWhere((phone) => phone.label == 'móvil').value;
      if (phoneString!.contains('+34')) {
        return phoneString;
      }
      return '+34 $phoneString';
    }

    return null;
  }

  List<Item> sanitizeItems(List<Item> items) {
    if (items.isNotEmpty) {
      var seen = <String>{};
      return items.where((item) => seen.add(item.value ?? '')).toList();
    }

    return [];
  }

  void toggleFavorite() {
    FavoritesDb favoriteDb = FavoritesDb();
    bool toggleFav = !isFavorite;
    if (!toggleFav) {
      favoriteDb.removeFavorite(identifier ?? '');
    } else {
      favoriteDb.addFavorite(identifier ?? '');
    }
  }

  ContactModel copyWith({
    String? id,
    Uint8List? newAvatar,
    bool? highImageLoaded,
  }) {
    return ContactModel(
      id: id ?? identifier,
      displayName: displayName,
      givenName: givenName,
      middleName: middleName,
      prefix: prefix,
      suffix: suffix,
      familyName: familyName,
      company: company,
      jobTitle: jobTitle,
      emails: emails,
      phones: phones,
      postalAddresses: postalAddresses,
      avatar: newAvatar ?? avatar,
      highImageLoaded: highImageLoaded ?? this.highImageLoaded,
      birthday: birthday,
      androidAccountType: androidAccountType,
      androidAccountTypeRaw: androidAccountTypeRaw,
      androidAccountName: androidAccountName,
    );
  }
}
