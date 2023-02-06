import 'package:flutter/material.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';
import 'package:contactos_app/shared/widgets/shared_widgets.dart';

class RecientesCardContainer extends StatelessWidget {
  const RecientesCardContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ContactItem> getRecientes(List<ContactModel> contactos) {
      return contactos
          .map((c) => ContactItem(
                contact: c,
              ))
          .take(5)
          .toList();
    }

    // return CardContainer(
    //     child: Column(
    //   children: [
    //     const _RecientesFilterButtons(),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     ...getRecientes(contactsFake)
    //   ],
    // ));
    return Container();
  }
}

class _RecientesFilterButtons extends StatefulWidget {
  const _RecientesFilterButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<_RecientesFilterButtons> createState() =>
      _RecientesFilterButtonsState();
}

class _RecientesFilterButtonsState extends State<_RecientesFilterButtons> {
  ActiveButton _activeFilter = ActiveButton.left;

  @override
  Widget build(BuildContext context) {
    return FilterUnionButton(
      onTapLeftButton: () {
        // TODO: Obtener 5 vistos recientemente del storage
        setState(() {
          _activeFilter = ActiveButton.left;
        });
      },
      onTapRightButton: () {
        // TODO: Obtener 5 añadidos recientemente del storage
        setState(() {
          _activeFilter = ActiveButton.right;
        });
      },
      textLeftButton: 'Vistas recientemente',
      textRightButton: 'Añadidas recientemente',
      activeButton: _activeFilter,
    );
  }
}
