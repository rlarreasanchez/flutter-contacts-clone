import 'package:flutter/material.dart';

class ContactsTag extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool active;
  final void Function() onTap;
  final bool isSelectable;

  const ContactsTag(
      {super.key,
      required this.icon,
      required this.title,
      required this.active,
      required this.onTap,
      this.isSelectable = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: TextButton.icon(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
              (active) ? const Color(0xffC2E7FF) : Colors.white),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 10),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(
                color: Colors.black26,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        label: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            if (active || isSelectable)
              const SizedBox(
                width: 5,
              ),
            if (active)
              const Icon(
                Icons.close,
                color: Colors.black87,
                size: 20,
              ),
            if (isSelectable)
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.black87,
                size: 20,
              )
          ],
        ),
        icon: Icon(
          icon,
          size: 20,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
