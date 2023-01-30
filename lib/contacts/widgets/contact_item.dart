import 'package:contactos_app/contacts/widgets/regex_text_highlight.dart';
import 'package:flutter/material.dart';
import 'package:contactos_app/contacts/models/contact_model.dart';

class ContactItem extends StatelessWidget {
  final String? highlightText;
  final bool highlight;

  ContactItem(
      {Key? key,
      required this.contact,
      this.highlightText,
      this.highlight = false})
      : super(key: key);

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: CircleAvatar(
              backgroundImage: NetworkImage(contact.imgUrl),
              backgroundColor: Colors.transparent,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: highlight
                  ? RegexTextHighlight(
                      text: contact.name,
                      highlightRegex:
                          RegExp(highlightText ?? '', caseSensitive: false),
                      highlightStyle: highlighStyle,
                      nonHighlightStyle: notHighlighStyle)
                  : Text(
                      contact.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18),
                    ),
            ),
          )
        ],
      ),
    );
  }

  final TextStyle highlighStyle = TextStyle(
      fontSize: 18, color: Colors.red[600], fontWeight: FontWeight.w700);

  final TextStyle notHighlighStyle =
      const TextStyle(fontSize: 18, color: Colors.black);
}
