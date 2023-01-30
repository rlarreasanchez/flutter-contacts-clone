import 'package:diacritic/diacritic.dart';

class ContactModel {
  final int id;
  final String imgUrl;
  final String name;
  final String email;
  final bool? favorite;

  ContactModel({
    required this.id,
    required this.imgUrl,
    required this.name,
    required this.email,
    this.favorite = false,
  }) : super();

  bool containsTermByName(String term) {
    return removeDiacritics(name.toLowerCase())
        .contains(removeDiacritics(term.toLowerCase()));
  }

  bool containsTermByEmail(String term) {
    return removeDiacritics(email.toLowerCase())
        .contains(removeDiacritics(term.toLowerCase()));
  }
}
