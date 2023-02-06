import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/main.dart';
import 'package:contactos_app/extensions/string_extension.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
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
            ContactCardContainer(title: 'Información de contacto', children: [
              if (contactRef!.phonesSanitized.isNotEmpty)
                ...contactRef.phonesSanitized.map(
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
              if (contactRef.emailsSanitized.isNotEmpty)
                ...contactRef.emailsSanitized.map(
                  (email) => ContactInfoRow(
                    headerIcon: Icons.mail_outline,
                    title: email.value!,
                    onTap: () async {
                      if (email.value!.isNotEmpty) {
                        await ContactsUtils.launchContactUrl(
                            "mailto:${email.value!}");
                      }
                    },
                  ),
                )
            ]),
            const SizedBox(
              height: 20,
            ),
            const ContactCardContainer(title: 'Información general', children: [
              ContactInfoRow(
                headerIcon: Icons.business_sharp,
                title: 'MAGTEL',
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
