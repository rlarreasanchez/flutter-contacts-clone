import 'package:flutter/material.dart';

class ContactInfoRow extends StatelessWidget {
  final IconData headerIcon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? headerIconColor;
  final void Function()? onTap;

  const ContactInfoRow({
    Key? key,
    required this.headerIcon,
    required this.title,
    this.headerIconColor,
    this.onTap,
    this.trailing,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              headerIcon,
              color: headerIconColor ?? Colors.black87,
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    )
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            if (trailing != null) trailing!
          ],
        ),
      ),
    );
  }
}
