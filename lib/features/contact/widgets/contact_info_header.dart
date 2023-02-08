import 'dart:developer';

import 'package:async/async.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contact/providers/contact_provider.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:contactos_app/constants/ui_constants.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';

class ContactInfoHeader extends ConsumerStatefulWidget {
  final ContactModel contact;
  const ContactInfoHeader({
    required this.contact,
    Key? key,
  }) : super(key: key);

  @override
  ContactInfoHeaderState createState() => ContactInfoHeaderState();
}

class ContactInfoHeaderState extends ConsumerState<ContactInfoHeader> {
  CancelableOperation? _myCancelableFuture;

  // Future<void> getAvatar() async {
  //   _myCancelableFuture = CancelableOperation.fromFuture(
  //     ref.read(contactProvider.notifier).setAvatar(),
  //     onCancel: () => 'Future has been canceld',
  //   );

  //   final avatarResponse = await _myCancelableFuture?.value;

  //   setState(() {
  //     avatar = avatarResponse;
  //     isLoading = false;
  //   });
  // }

  @override
  void initState() {
    ref.read(contactProvider.notifier).setAvatar();
    super.initState();
  }

  @override
  void dispose() {
    _myCancelableFuture?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contact = ref.watch(contactProvider);

    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        height: contact != null &&
                contact.avatar != null &&
                contact.avatar!.isNotEmpty
            ? UiConstants.contactHeaderLarge
            : UiConstants.contactHeaderSmall,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: _ContactAvatar(
                  id: widget.contact.identifier ?? '0',
                  avatar: contact!.avatar,
                  isLoading: false,
                  letter: widget.contact.displayName != null &&
                          widget.contact.displayName!.isNotEmpty
                      ? widget.contact.displayName![0].toUpperCase()
                      : ''),
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    (widget.contact.displayName ?? '')
                        .replaceAll(' ', '\u{000A0}'),
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

class _ContactAvatar extends ConsumerWidget {
  final Uint8List? avatar;
  final bool isLoading;
  final String letter;
  final String id;

  const _ContactAvatar(
      {required this.id,
      this.avatar,
      required this.isLoading,
      required this.letter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // if (avatar != null) {
    //   ref.read(contactProvider.notifier).state!.avatar = avatar;
    // }

    // if (isLoading) {
    //   return Center(
    //     child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
    //   );
    // }

    return avatar != null && avatar!.isNotEmpty
        ? Image.memory(
            avatar!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
          )
        : CircleAvatar(
            backgroundColor: ContactsUtils.getColor(id),
            maxRadius: 45,
            child: Text(
              letter,
              style: const TextStyle(fontSize: 45, color: Colors.white),
            ),
          );
  }
}
