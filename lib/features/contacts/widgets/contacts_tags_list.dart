import 'package:flutter/material.dart';
import 'package:contactos_app/features/contacts/models/tag_item_model.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';

class ContactsTagsList extends StatelessWidget {
  const ContactsTagsList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TagItemModel> items = [
      TagItemModel('Contactos telefónicos', Icons.phone_outlined),
      TagItemModel('Contactos de correo', Icons.mail_outline),
      TagItemModel('Empresa', Icons.business_outlined, true),
    ];

    List<ContactsTag> getTags(List<TagItemModel> tags) {
      return tags
          .map((tag) => ContactsTag(
                icon: tag.icon,
                title: tag.title,
              ))
          .toList();
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        const SizedBox(
          width: 10.0,
        ),
        ...getTags(items),
        const SizedBox(
          width: 10.0,
        ),
      ],
    );
  }
}
