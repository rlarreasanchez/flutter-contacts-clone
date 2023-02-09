import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.phone_outlined,
                color: Color(0xff0B57D0),
                size: 30,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Llamar',
                style: TextStyle(
                    color: Color(0xff0B57D0),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        if (contactosRef.activeContact!.phonesSanitized.isNotEmpty)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.comment_outlined,
                color: Color(0xff0B57D0),
                size: 30,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'SMS',
                style: TextStyle(
                    color: Color(0xff0B57D0),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        if (contactosRef.activeContact!.emailsSanitized.isNotEmpty)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.mail_outline,
                color: Color(0xff0B57D0),
                size: 30,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Correo',
                style: TextStyle(
                    color: Color(0xff0B57D0),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
      ]),
    );
  }
}
