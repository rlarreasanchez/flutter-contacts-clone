import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:contactos_app/constants/ui_constants.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';

class ContactInfoHeader extends ConsumerWidget {
  final ContactModel contact;
  const ContactInfoHeader({
    required this.contact,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsRef = ref.watch(contactsProvider);

    if (contactsRef.activeContact == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        height: contactsRef.activeContact!.avatar != null &&
                contactsRef.activeContact!.avatar!.isNotEmpty
            ? UiConstants.contactHeaderLarge
            : UiConstants.contactHeaderSmall,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: _ContactAvatar(
                  color: contact.color,
                  avatar: contactsRef.activeContact!.avatar,
                  isLoading: false,
                  letter: contact.displayName != null &&
                          contact.displayName!.isNotEmpty
                      ? contact.displayName![0].toUpperCase()
                      : ''),
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    (contact.displayName ?? '').replaceAll(' ', '\u{000A0}'),
                    style: const TextStyle(color: Colors.black87, fontSize: 26),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ContactAvatar extends StatelessWidget {
  final Uint8List? avatar;
  final bool isLoading;
  final String letter;
  final Color color;

  const _ContactAvatar(
      {required this.color,
      this.avatar,
      required this.isLoading,
      required this.letter});

  @override
  Widget build(BuildContext context) {
    return avatar != null && avatar!.isNotEmpty
        ? Image.memory(
            avatar!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
          )
        : CircleAvatar(
            backgroundColor: color,
            maxRadius: 45,
            child: Text(
              letter,
              style: const TextStyle(fontSize: 45, color: Colors.white),
            ),
          );
  }
}
