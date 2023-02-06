import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/main.dart';
import 'package:contactos_app/shared/utils/utils.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';

class ContactItem extends ConsumerWidget {
  final ContactModel contact;
  final String? highlightText;
  final bool highlight;
  final bool withFavIcon;

  const ContactItem(
      {Key? key,
      required this.contact,
      this.highlightText,
      this.highlight = false,
      this.withFavIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool showEmail = false;
    if (highlight &&
        Utils.containsStringTerm(
            contact.displayName ?? '', highlightText ?? '')) {
      showEmail = false;
    } else if (highlight &&
        Utils.containsListTerm(
            contact.emails!.map((email) => email.value ?? '').toList(),
            highlightText ?? '')) {
      showEmail = true;
    }
    final TextStyle highlighStyle = TextStyle(
        fontSize: 16,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w500);

    const TextStyle notHighlighStyle =
        TextStyle(fontSize: 16, color: Colors.black);

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
              child: _ContactAvatarItem(
                contact: contact,
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
                              text: contact.displayName ?? '',
                              highlightRegex: RegExp(highlightText ?? '',
                                  caseSensitive: false),
                              highlightStyle: highlighStyle,
                              nonHighlightStyle: notHighlighStyle)
                          : Text(
                              contact.displayName ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: notHighlighStyle,
                            ),
                      showEmail
                          ? RegexTextHighlight(
                              text: Utils.stringListTerm(
                                  contact.emails!
                                      .map((email) => email.value ?? '')
                                      .toList(),
                                  highlightText ?? ''),
                              highlightRegex: RegExp(highlightText ?? '',
                                  caseSensitive: false),
                              highlightStyle: highlighStyleSecondary,
                              nonHighlightStyle: notHighlighStyleSecondary)
                          : const SizedBox()
                    ],
                  )),
            ),
            // if (withFavIcon)
            //   Padding(
            //     padding: const EdgeInsets.only(right: 40.0),
            //     child: IconButton(
            //         // TODO: Llamar a hacer el toggle de favorito del contacto
            //         onPressed: () {},
            //         icon: (contact.favorite ?? false)
            //             ? Icon(
            //                 Icons.star,
            //                 color: Theme.of(context).primaryColor,
            //               )
            //             : const Icon(
            //                 Icons.star_outline,
            //                 color: Colors.black54,
            //               )),
            //   )
          ],
        ),
      ),
    );
  }
}

class _ContactAvatarItem extends StatefulWidget {
  final ContactModel contact;
  const _ContactAvatarItem({required this.contact});

  @override
  State<_ContactAvatarItem> createState() => __ContactAvatarItemState();
}

class __ContactAvatarItemState extends State<_ContactAvatarItem> {
  Uint8List? avatar;

  Future<void> getAvatar() async {
    final avatarResponse = await ContactsService.getAvatar(widget.contact);
    setState(() {
      avatar = avatarResponse;
    });
  }

  @override
  void initState() {
    getAvatar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return avatar != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.memory(
              avatar!,
              width: 40,
              height: 40,
            ),
          )
        : CircleAvatar(
            backgroundColor:
                ContactsUtils.getColor(widget.contact.identifier ?? '0'),
            radius: 20,
            child: Text(
              widget.contact.displayName![0].toUpperCase(),
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
  }
}
