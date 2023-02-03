import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/main.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';

class ContactItem extends ConsumerWidget {
  final ContactModel contact;
  final String? highlightText;
  final bool highlight;

  const ContactItem(
      {Key? key,
      required this.contact,
      this.highlightText,
      this.highlight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool showEmail = false;
    if (highlight && contact.containsTermByName(highlightText ?? '')) {
      showEmail = false;
    } else if (highlight && contact.containsTermByEmail(highlightText ?? '')) {
      showEmail = true;
    }
    final TextStyle highlighStyle = TextStyle(
        fontSize: 18,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w500);

    const TextStyle notHighlighStyle =
        TextStyle(fontSize: 18, color: Colors.black);

    final TextStyle highlighStyleSecondary = TextStyle(
        fontSize: 14,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w500);

    const TextStyle notHighlighStyleSecondary =
        TextStyle(fontSize: 14, color: Colors.black54);

    return InkWell(
      onTap: () {
        Future.delayed(const Duration(milliseconds: 150), () {
          ref.read(contactProvider.notifier).state = contact;
          Navigator.pushNamed(context, 'contact', arguments: contact);
        });
      },
      splashColor: Colors.grey[400],
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: contact.imgUrl.isEmpty
                  ? CircleAvatar(
                      backgroundColor: contact.color,
                      child: Text(
                        contact.name[0].toUpperCase(),
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(contact.imgUrl),
                      backgroundColor: Colors.transparent,
                    ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      highlight
                          ? RegexTextHighlight(
                              text: contact.name,
                              highlightRegex: RegExp(highlightText ?? '',
                                  caseSensitive: false),
                              highlightStyle: highlighStyle,
                              nonHighlightStyle: notHighlighStyle)
                          : Text(
                              contact.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: notHighlighStyle,
                            ),
                      showEmail && contact.email.isEmpty
                          ? RegexTextHighlight(
                              text: contact.email,
                              highlightRegex: RegExp(highlightText ?? '',
                                  caseSensitive: false),
                              highlightStyle: highlighStyleSecondary,
                              nonHighlightStyle: notHighlighStyleSecondary)
                          : const SizedBox()
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
