import 'package:contacts_service/contacts_service.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/animation.dart';

class ContactModel extends Contact {
  List<Item> emailsSanitized = [];
  List<Item> phonesSanitized = [];
  bool? isFavorite;
  Color? color;

  ContactModel() : super();

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
    phonesSanitized = sanitizeItems(contact.phones ?? []);
  }

  List<Item> sanitizeItems(List<Item> items) {
    if (items.isNotEmpty) {
      var seen = <String>{};
      return items.where((item) => seen.add(item.label ?? '')).toList();
    }

    return [];
  }

  bool containsTermByName(String term) {
    return removeDiacritics(displayName?.toLowerCase() ?? '')
        .contains(removeDiacritics(term.toLowerCase()));
  }

  bool containsTermByEmail(String term) {
    return false;
  }
}
