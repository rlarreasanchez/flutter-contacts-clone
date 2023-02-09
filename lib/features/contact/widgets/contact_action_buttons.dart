import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:contactos_app/extensions/string_extension.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';

class CallActionsButtons extends ConsumerWidget {
  const CallActionsButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactosRef = ref.watch(contactsProvider);

    if (contactosRef.activeContact == null) {
      return const Text('Cargando...');
    }

    return Container(
      height: 90,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        if (contactosRef.activeContact!.phonesSanitized.isNotEmpty)
          const _CallContactButton(),
        if (contactosRef.activeContact!.phonesSanitized.isNotEmpty)
          const _SmsContactButton(),
        if (contactosRef.activeContact!.emailsSanitized.isNotEmpty)
          const _MailContactButton(),
      ]),
    );
  }
}

class _MailContactButton extends ConsumerWidget {
  const _MailContactButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeContact = ref.watch(contactsProvider).activeContact;

    return InkWell(
      onTap: () async {
        if (activeContact!.emailsSanitized.length == 1) {
          await ContactsUtils.launchContactUrl(
              "mailto:${activeContact.emailsSanitized[0].value!}");
          return;
        }
        showDialog(
          context: context,
          builder: ((context) => _AlertCallDialog(
                callList: activeContact.emailsSanitized,
              )),
        ).then((emailSelected) async {
          if (emailSelected != null) {
            await ContactsUtils.launchContactUrl("mailto:$emailSelected");
          }
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mail_outline,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Correo',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class _SmsContactButton extends ConsumerWidget {
  const _SmsContactButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeContact = ref.watch(contactsProvider).activeContact;

    return InkWell(
      onTap: () async {
        if (activeContact!.phonesSanitized.length == 1) {
          await ContactsUtils.launchContactUrl(
              "sms:${activeContact.phonesSanitized[0].value!}");
          return;
        }
        showDialog(
          context: context,
          builder: ((context) => _AlertCallDialog(
                callList: activeContact.phonesSanitized,
              )),
        ).then((phoneSelected) async {
          if (phoneSelected != null) {
            await ContactsUtils.launchContactUrl("sms:$phoneSelected");
          }
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.comment_outlined,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'SMS',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class _CallContactButton extends ConsumerWidget {
  const _CallContactButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeContact = ref.watch(contactsProvider).activeContact;

    return InkWell(
      onTap: () async {
        if (activeContact!.phonesSanitized.length == 1) {
          await ContactsUtils.launchContactUrl(
              "tel:${activeContact.phonesSanitized[0].value!}");
          return;
        }
        showDialog(
          context: context,
          builder: ((context) => _AlertCallDialog(
                callList: activeContact.phonesSanitized,
              )),
        ).then((phoneSelected) async {
          if (phoneSelected != null) {
            await ContactsUtils.launchContactUrl("tel:$phoneSelected");
          }
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.phone_outlined,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Llamar',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class _AlertCallDialog extends StatefulWidget {
  final List<Item> callList;
  const _AlertCallDialog({
    Key? key,
    required this.callList,
  }) : super(key: key);

  @override
  State<_AlertCallDialog> createState() => _AlertCallDialogState();
}

class _AlertCallDialogState extends State<_AlertCallDialog> {
  late String selectedRadio;
  late String selectedRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRadio = '';
    selectedRadioTile = '';
  }

  setSelectedRadioTile(String val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Llamar a:"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.callList.map((item) => RadioListTile(
                value: item.value,
                groupValue: selectedRadioTile,
                title: Text(
                  item.value ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text((item.label ?? '').capitalize()),
                onChanged: (val) {
                  setSelectedRadioTile(val!);
                },
                activeColor: Theme.of(context).primaryColor,
                selected: selectedRadio == item.value,
              ))
        ],
      ),
      actions: [
        TextButton(
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor,
            disabledForegroundColor:
                Colors.grey.withOpacity(0.38), // Disable color
          ),
          onPressed: (selectedRadioTile.isEmpty)
              ? null
              : () {
                  Navigator.pop(context, selectedRadioTile);
                },
          child: const Text(
            "Continuar",
          ),
        ),
      ],
    );
  }
}
