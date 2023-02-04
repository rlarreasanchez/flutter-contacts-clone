import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final void Function() onTap;
  final IconData startIcon;
  final String hintText;

  const SearchBar({
    Key? key,
    required this.onTap,
    required this.startIcon,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: const Color(0xffF2F5FB),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 227, 230, 234))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            SizedBox(
              child: Hero(
                  tag: 'backIcon',
                  flightShuttleBuilder: (
                    BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext,
                  ) {
                    final Widget toHero = toHeroContext.widget;
                    return RotationTransition(
                      turns: animation.drive(Tween(begin: 0, end: 2)),
                      child: toHero,
                    );
                  },
                  child: Icon(startIcon, size: 24, color: Colors.black45)),
            ),
            const SizedBox(
              width: 20,
            ),
            Hero(
              tag: 'searchInput',
              child: Material(
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: const Color(0xffF2F5FB),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 0),
                    ),
                    autofocus: false,
                    enabled: false,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
