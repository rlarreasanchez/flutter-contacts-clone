import 'package:contactos_app/contacts/widgets/contact_info_row.dart';
import 'package:contactos_app/shared/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:contactos_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactRef = ref.watch(contactProvider);

    if (contactRef == null) {
      return const Text('Cargando...');
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const _ContactAppBar(),
        body: CustomScrollView(
          slivers: [
            const _ContactHeader(),
            SliverStickyHeader(
                header: const _CallActionsButtons(),
                sliver: const _ContactInfo()),
          ],
        ));
  }
}

class _ContactInfo extends ConsumerWidget {
  const _ContactInfo({
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
                CardContainer(title: 'Información de contacto', children: [
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
                        headerIcon: Icons.mail_outline, title: contactRef.email)
                ]),
                const SizedBox(
                  height: 20,
                ),
                const CardContainer(title: 'Información general', children: [
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

class _ContactAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _ContactAppBar({
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
      title: Text(
        contactRef!.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class _ContactHeader extends ConsumerWidget {
  const _ContactHeader({
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
        height: contactRef!.imgUrl.isEmpty ? 220 : 330,
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

class _CallActionsButtons extends ConsumerWidget {
  const _CallActionsButtons({
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
        if (contactoRef.email.isNotEmpty)
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
