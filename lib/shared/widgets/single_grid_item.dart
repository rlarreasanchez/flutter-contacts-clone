import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SingleGridItem extends StatelessWidget {
  final Widget header;
  final String title;
  final Color color;
  final void Function() onTap;

  const SingleGridItem(
      {super.key,
      required this.header,
      required this.title,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: FadeIn(
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              SizedBox(height: 60, child: header),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                child: Text(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
