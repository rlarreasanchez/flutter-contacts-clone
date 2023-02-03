import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/main.dart';
import 'package:contactos_app/features/contact/widgets/contact_widgets.dart';

class ContactInfo extends ConsumerWidget {
  const ContactInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactRef = ref.watch(contactProvider);

    return SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ContactCardContainer(
                    title: 'Información de contacto',
                    children: [
                      const ContactInfoRow(
                        headerIcon: Icons.phone_outlined,
                        title: '658 56 56 89',
                        subtitle: 'Móvil',
                        endIcon: Icons.comment_outlined,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (contactRef!.email.isNotEmpty)
                        ContactInfoRow(
                            headerIcon: Icons.mail_outline,
                            title: contactRef.email)
                    ]),
                const SizedBox(
                  height: 20,
                ),
                const ContactCardContainer(
                    title: 'Información general',
                    children: [
                      ContactInfoRow(
                          headerIcon: Icons.business_sharp, title: 'MAGTEL')
                    ]),
                const SizedBox(
                  height: 200,
                ),
              ],
            )));
  }
}
