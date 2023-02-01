import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:contactos_app/main.dart';
import 'package:contactos_app/constants/ui_constants.dart';
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
        final limitHeight = (contactRef != null && contactRef.imgUrl.isEmpty)
            ? UiConstants.contactHeaderSmall
            : UiConstants.contactHeaderLarge;

        if (_controller.position.pixels > limitHeight - 20) {
          ref.read(showAppbarTitle.notifier).state = true;
        } else {
          ref.read(showAppbarTitle.notifier).state = false;
        }
      }
      return true;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: ContactAppBar(
          controller: _controller,
        ),
        body: NotificationListener<ScrollNotification>(
            onNotification: checkShowAppbarTitle,
            child: CustomScrollView(
              controller: _controller,
              slivers: [
                const ContactInfoHeader(),
                SliverStickyHeader(
                    header: const CallActionsButtons(),
                    sliver: const ContactInfo()),
              ],
            )));
  }
}
