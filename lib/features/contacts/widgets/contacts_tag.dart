import 'package:flutter/material.dart';

class ContactsTag extends StatelessWidget {
  final IconData icon;
  final String title;
  const ContactsTag({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: TextButton.icon(
          onPressed: () {},
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 10)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(
                    color: Colors.black26,
                    width: 2,
                    style: BorderStyle.solid))),
          ),
          label: Text(
            title,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          icon: Icon(
            icon,
            size: 20,
            color: Theme.of(context).primaryColor,
          )),
    );
  }
}
