import 'package:contactos_app/constants.dart';
import 'package:contactos_app/shared/utils/utils.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/animation.dart';

class ContactModel {
  final int id;
  final String imgUrl;
  final String name;
  final String email;
  final bool? favorite;
  Color? color;

  ContactModel({
    required this.id,
    required this.imgUrl,
    required this.name,
    this.email = '',
    this.favorite = false,
    this.color,
  }) {
    color = getColor();
  }

  bool containsTermByName(String term) {
    return removeDiacritics(name.toLowerCase())
        .contains(removeDiacritics(term.toLowerCase()));
  }

  bool containsTermByEmail(String term) {
    if (email.isEmpty) return false;
    return removeDiacritics(email.toLowerCase())
        .contains(removeDiacritics(term.toLowerCase()));
  }

  Color getColor() {
    final int nColors = Constants.contactsColors.length;

    return Constants.contactsColors[Utils.getRandomInt(0, nColors)];
  }
}
