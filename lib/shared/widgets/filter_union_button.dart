import 'package:flutter/material.dart';

enum ActiveButton { left, right }

class FilterUnionButton extends StatelessWidget {
  final String textLeftButton;
  final String textRightButton;
  final void Function() onTapLeftButton;
  final void Function() onTapRightButton;
  final ActiveButton activeButton;

  const FilterUnionButton(
      {super.key,
      required this.textLeftButton,
      required this.textRightButton,
      required this.onTapLeftButton,
      required this.onTapRightButton,
      this.activeButton = ActiveButton.left});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onTapLeftButton,
            style: ButtonStyle(
                padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 18, vertical: 15)),
                overlayColor: MaterialStatePropertyAll(Colors.grey[400]),
                backgroundColor: MaterialStatePropertyAll(
                    activeButton == ActiveButton.left
                        ? const Color(0xffC2E7FF)
                        : Colors.transparent),
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.zero,
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                  ),
                ),
                side: const MaterialStatePropertyAll(
                    BorderSide(width: 0.8, color: Colors.black87))),
            child: Text(
              textLeftButton.replaceAll(' ', '\u{000A0}'),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: OutlinedButton(
            onPressed: onTapRightButton,
            style: ButtonStyle(
                padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 18, vertical: 15)),
                overlayColor: MaterialStatePropertyAll(Colors.grey[400]),
                backgroundColor: MaterialStatePropertyAll(
                    activeButton == ActiveButton.right
                        ? const Color(0xffC2E7FF)
                        : Colors.transparent),
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        bottomLeft: Radius.zero,
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                ),
                side: const MaterialStatePropertyAll(
                    BorderSide(width: 0.8, color: Colors.black87))),
            child: Text(
              textRightButton.replaceAll(' ', '\u{000A0}'),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
