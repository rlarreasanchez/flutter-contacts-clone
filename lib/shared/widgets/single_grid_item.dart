import 'package:flutter/material.dart';

class SingleGridItem extends StatelessWidget {
  final String imgUrl;
  final String title;
  final Color color;
  final void Function() onTap;

  const SingleGridItem(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: imgUrl.isEmpty
                  ? CircleAvatar(
                      backgroundColor: color,
                      minRadius: 24,
                      child: Text(
                        title[0].toUpperCase(),
                        style:
                            const TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(imgUrl),
                      minRadius: 24,
                      backgroundColor: Colors.transparent,
                    ),
            ),
            Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
