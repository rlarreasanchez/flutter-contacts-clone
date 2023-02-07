import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';

class ContactAvatarItem extends ConsumerStatefulWidget {
  final ContactModel contact;
  final double radius;
  const ContactAvatarItem({super.key, required this.contact, this.radius = 20});

  @override
  ContactAvatarItemState createState() => ContactAvatarItemState();
}

class ContactAvatarItemState extends ConsumerState<ContactAvatarItem> {
  CancelableOperation? _myCancelableFuture;

  Future<void> getAvatar() async {
    _myCancelableFuture = CancelableOperation.fromFuture(
      ContactsService.getAvatar(widget.contact, photoHighRes: false),
      onCancel: () => 'Future has been canceld',
    );
    final avatarResponse = await _myCancelableFuture?.value;
    widget.contact.avatar = avatarResponse;
    ref.read(contactsProvider.notifier).updateContact(widget.contact);
  }

  @override
  void initState() {
    if (widget.contact.avatar == null || widget.contact.avatar!.isEmpty) {
      getAvatar();
    }
    super.initState();
  }

  @override
  void dispose() {
    _myCancelableFuture?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.contact.avatar != null && widget.contact.avatar!.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: Image.memory(
              widget.contact.avatar!,
              width: widget.radius * 2,
              height: widget.radius * 2,
            ),
          )
        : CircleAvatar(
            backgroundColor:
                ContactsUtils.getColor(widget.contact.identifier ?? '0'),
            radius: widget.radius,
            child: Text(
              widget.contact.displayName![0].toUpperCase(),
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
  }
}
