import 'package:animate_do/animate_do.dart';
import 'package:contactos_app/features/contact/screens/contact_screen.dart';
import 'package:contactos_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final ScrollController controller;

  const ContactAppBar({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactRef = ref.watch(contactProvider);

    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: const [
        Icon(Icons.edit_outlined),
        SizedBox(
          width: 20,
        ),
        Icon(Icons.star),
        SizedBox(
          width: 20,
        ),
        Icon(Icons.more_vert),
        SizedBox(
          width: 20,
        ),
      ],
      title: _ContactAppBarTitle(title: contactRef!.name),
    );
  }
}

class _ContactAppBarTitle extends ConsumerWidget {
  const _ContactAppBarTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showTitle = ref.watch(showAppbarTitle);

    return (showTitle)
        ? FadeIn(
            duration: const Duration(milliseconds: 400),
            child: Text(
              title.replaceAll(' ', '\u{000A0}'),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: Colors.black),
            ),
          )
        : const SizedBox();
  }
}
