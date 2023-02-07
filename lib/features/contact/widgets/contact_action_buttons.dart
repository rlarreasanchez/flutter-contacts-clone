import 'package:contactos_app/features/contact/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallActionsButtons extends ConsumerWidget {
  const CallActionsButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactoRef = ref.watch(contactProvider);

    if (contactoRef == null) {
      return const Text('Cargando...');
    }

    return Container(
      height: 90,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.video_camera_front_outlined,
              color: Color(0xff0B57D0),
              size: 30,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Configurar',
              style: TextStyle(
                  color: Color(0xff0B57D0),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        if (contactoRef.emails != null && contactoRef.emails!.isNotEmpty)
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
