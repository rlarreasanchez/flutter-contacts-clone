import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const CardContainer({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Color(0xffF2F5FB),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
          ),
        ),
      ],
    );
  }
}
