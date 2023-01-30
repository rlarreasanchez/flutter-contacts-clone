import 'package:flutter/material.dart';
import 'package:contactos_app/contacts/screens/search_screen.dart';

class ContactsSearchBar extends StatelessWidget {
  const ContactsSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return const SearchScreen();
              },
            ),
          );
        },
        child: Container(
          height: 55,
          decoration: BoxDecoration(
              color: const Color(0xffF2F5FB),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  width: 1, color: const Color.fromARGB(255, 227, 230, 234))),
          child: Row(
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
                    child: const Icon(Icons.menu,
                        size: 24, color: Colors.black45)),
              ),
              const SizedBox(
                width: 20,
              ),
              const Hero(
                tag: 'searchInput',
                child: Material(
                  child: SizedBox(
                    width: 200,
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Buscar contactos',
                        hintStyle: TextStyle(color: Colors.black54),
                        filled: true,
                        fillColor: Color(0xffF2F5FB),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 0),
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
      ),
    );
  }
}
