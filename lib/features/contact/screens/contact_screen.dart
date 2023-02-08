import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:contactos_app/constants/ui_constants.dart';
import 'package:contactos_app/features/contact/providers/contact_provider.dart';
import 'package:contactos_app/features/contact/widgets/contact_widgets.dart';

final showAppbarTitle = StateProvider.autoDispose<bool>((ref) => false);

class ContactScreen extends ConsumerWidget {
  final ScrollController _controller = ScrollController();

  ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactRef = ref.watch(contactProvider);

    bool checkShowAppbarTitle(ScrollNotification notification) {
      if (notification is ScrollUpdateNotification) {
        final limitHeight = (contactRef != null &&
                contactRef.avatar != null &&
                contactRef.avatar!.isNotEmpty)
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

    if (contactRef == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
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
            ContactInfoHeader(contact: contactRef),
            SliverStickyHeader(
                header: const CallActionsButtons(),
                sliver: const ContactInfo()),
          ],
        ),
      ),
    );
  }
}
