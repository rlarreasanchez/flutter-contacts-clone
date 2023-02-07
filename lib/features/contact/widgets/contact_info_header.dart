import 'package:async/async.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contact/providers/contact_provider.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:contactos_app/constants/ui_constants.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';

class ContactInfoHeader extends StatefulWidget {
  final ContactModel contact;
  const ContactInfoHeader({
    required this.contact,
    Key? key,
  }) : super(key: key);

  @override
  State<ContactInfoHeader> createState() => _ContactInfoHeaderState();
}

class _ContactInfoHeaderState extends State<ContactInfoHeader> {
  Uint8List? avatar;
  bool isLoading = true;
  CancelableOperation? _myCancelableFuture;

  Future<void> getAvatar() async {
    setState(() {
      isLoading = true;
    });

    _myCancelableFuture = CancelableOperation.fromFuture(
      ContactsService.getAvatar(widget.contact),
      onCancel: () => 'Future has been canceld',
    );

    final avatarResponse = await _myCancelableFuture?.value;

    setState(() {
      avatar = avatarResponse;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getAvatar();
    super.initState();
  }

  @override
  void dispose() {
    _myCancelableFuture?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        height: avatar != null && !isLoading
            ? UiConstants.contactHeaderLarge
            : UiConstants.contactHeaderSmall,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: _ContactAvatar(
                  id: widget.contact.identifier ?? '0',
                  avatar: avatar,
                  isLoading: isLoading,
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
    if (avatar != null) {
      ref.read(contactProvider.notifier).state!.avatar = avatar;
    }

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
      );
    }

    return avatar != null
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
