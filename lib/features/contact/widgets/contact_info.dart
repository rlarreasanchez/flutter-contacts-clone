import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/extensions/string_extension.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:contactos_app/features/contact/widgets/contact_widgets.dart';

class ContactInfo extends ConsumerWidget {
  const ContactInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsRef = ref.watch(contactsProvider);

    if (contactsRef.activeContact == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ContactCardContainer(title: 'Información de contacto', children: [
              if (contactsRef.activeContact!.phonesSanitized.isNotEmpty)
                ...contactsRef.activeContact!.phonesSanitized.map(
                  (phone) => ContactInfoRow(
                    headerIcon: Icons.phone_outlined,
                    title: phone.value ?? '',
                    subtitle: phone.label?.capitalize(),
                    trailing: InkWell(
                      onTap: () async {
                        if (phone.value!.isNotEmpty) {
                          await ContactsUtils.launchContactUrl(
                              "sms:${phone.value!}");
                        }
                      },
                      child: const Icon(
                        Icons.comment_outlined,
                        size: 20,
                      ),
                    ),
                    onTap: () async {
                      if (phone.value!.isNotEmpty) {
                        await ContactsUtils.launchContactUrl(
                            "tel:${phone.value!}");
                      }
                    },
                  ),
                ),
              if (contactsRef.activeContact!.emailsSanitized.isNotEmpty)
                ...contactsRef.activeContact!.emailsSanitized.map(
                  (email) => ContactInfoRow(
                    headerIcon: Icons.mail_outline,
                    title: email.value!,
                    subtitle: email.label?.capitalize(),
                    onTap: () async {
                      if (email.value!.isNotEmpty) {
                        await ContactsUtils.launchContactUrl(
                            "mailto:${email.value!}");
                      }
                    },
                  ),
                ),
              if (contactsRef.activeContact!.whatsAppPhone != null)
                ContactInfoRow(
                  headerIcon: Icons.whatsapp_rounded,
                  headerIconColor: Colors.green,
                  title:
                      'Mandar Whatsapp a ${contactsRef.activeContact!.whatsAppPhone}',
                  onTap: () async {
                    await ContactsUtils.launchContactUrl(
                        "whatsapp://send?phone=${contactsRef.activeContact!.whatsAppPhone}");
                  },
                ),
            ]),
            const SizedBox(
              height: 20,
            ),
            if (contactsRef.activeContact!.company != null &&
                contactsRef.activeContact!.company!.isNotEmpty)
              ContactCardContainer(title: 'Información general', children: [
                ContactInfoRow(
                  headerIcon: Icons.business_sharp,
                  title: contactsRef.activeContact!.company!.toUpperCase(),
                )
              ]),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
