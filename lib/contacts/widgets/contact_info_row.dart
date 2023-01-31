import 'package:flutter/material.dart';

class ContactInfoRow extends StatelessWidget {
  final IconData headerIcon;
  final String title;
  final String? subtitle;
  final IconData? endIcon;

  const ContactInfoRow({
    Key? key,
    required this.headerIcon,
    required this.title,
    this.endIcon,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          headerIcon,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                )
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        if (endIcon != null) ...[
          Icon(endIcon),
          const SizedBox(
            width: 20,
          ),
        ]
      ],
    );
  }
}
