import 'package:diacritic/diacritic.dart';
import 'package:flutter/animation.dart';
import 'package:contactos_app/constants/ui_constants.dart';
import 'package:contactos_app/shared/utils/utils.dart';

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
    final int nColors = UiConstants.contactsColors.length;

    return UiConstants.contactsColors[Utils.getRandomInt(0, nColors)];
  }
}
