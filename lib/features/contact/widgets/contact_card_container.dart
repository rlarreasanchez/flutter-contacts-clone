import 'package:contactos_app/shared/widgets/card_container.dart';
import 'package:flutter/material.dart';

class ContactCardContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ContactCardContainer(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black87),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ...children
        ],
      ),
    );
  }
}
