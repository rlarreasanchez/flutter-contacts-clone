import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  const CardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Color(0xffF2F5FB),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
              child: child),
        ),
      ],
    );
  }
}
