import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/main.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:contactos_app/constants/ui_constants.dart';

class ContactInfoHeader extends ConsumerWidget {
  const ContactInfoHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactRef = ref.watch(contactProvider);

    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        height: contactRef != null &&
                contactRef.avatar != null &&
                contactRef.avatar!.isNotEmpty
            ? UiConstants.contactHeaderLarge
            : UiConstants.contactHeaderSmall,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child:
                    contactRef!.avatar != null && contactRef.avatar!.isNotEmpty
                        ? Image.memory(
                            contactRef.avatar!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                          )
                        : CircleAvatar(
                            backgroundColor: ContactsUtils.getColor(),
                            maxRadius: 45,
                            child: Text(
                              contactRef.displayName![0].toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 45, color: Colors.white),
                            ),
                          )),
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    (contactRef.displayName ?? '').replaceAll(' ', '\u{000A0}'),
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
