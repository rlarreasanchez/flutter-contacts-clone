import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:contactos_app/constants/ui_constants.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
import 'package:contactos_app/features/contact/widgets/contact_widgets.dart';

final showAppbarTitle = StateProvider.autoDispose<bool>((ref) => false);

class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({super.key});

  @override
  ContactScreenState createState() => ContactScreenState();
}

class ContactScreenState extends ConsumerState<ContactScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    ref.read(contactsProvider.notifier).setActiveAvatar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contactsRef = ref.watch(contactsProvider);

    bool checkShowAppbarTitle(ScrollNotification notification) {
      if (notification is ScrollUpdateNotification) {
        final limitHeight = (contactsRef.activeContact != null &&
                contactsRef.activeContact!.avatar != null &&
                contactsRef.activeContact!.avatar!.isNotEmpty)
            ? UiConstants.contactHeaderLarge
            : UiConstants.contactHeaderSmall;

        if (_controller.position.pixels > limitHeight - 20) {
          ref.read(showAppbarTitle.notifier).state = true;
        } else {
          ref.read(showAppbarTitle.notifier).state = false;
        }
      }
      return true;
    }

    if (contactsRef.activeContact == null) {
      return Container();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ContactAppBar(
        controller: _controller,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: checkShowAppbarTitle,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _controller,
          slivers: [
            ContactInfoHeader(contact: contactsRef.activeContact!),
            SliverStickyHeader(
                header: const CallActionsButtons(),
                sliver: const ContactInfo()),
          ],
        ),
      ),
    );
  }
}
