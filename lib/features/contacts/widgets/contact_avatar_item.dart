import 'package:flutter/material.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';

class ContactAvatarItem extends StatelessWidget {
  final ContactModel contact;
  final double radius;
  const ContactAvatarItem({super.key, required this.contact, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    return contact.avatar != null && contact.avatar!.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.memory(
              contact.avatar!,
              width: radius * 2,
              height: radius * 2,
            ),
          )
        : CircleAvatar(
            backgroundColor: contact.color,
            radius: radius,
            child: Text(
              contact.displayName![0].toUpperCase(),
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
  }
}
