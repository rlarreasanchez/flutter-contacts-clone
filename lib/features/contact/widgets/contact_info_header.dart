import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/main.dart';
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
        height: contactRef!.imgUrl.isEmpty
            ? UiConstants.contactHeaderSmall
            : UiConstants.contactHeaderLarge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: contactRef.imgUrl.isEmpty
                  ? CircleAvatar(
                      backgroundColor: contactRef.color,
                      maxRadius: 45,
                      child: Text(
                        contactRef.name[0].toUpperCase(),
                        style:
                            const TextStyle(fontSize: 45, color: Colors.white),
                      ),
                    )
                  : Image.network(
                      contactRef.imgUrl,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
            ),
            SizedBox(
              height: 70,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  contactRef.name,
                  style: const TextStyle(color: Colors.black87, fontSize: 26),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
