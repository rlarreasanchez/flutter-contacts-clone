import 'package:flutter/material.dart';
import 'package:contactos_app/shared/widgets/shared_widgets.dart';

class FavoritesEmptyContainer extends StatelessWidget {
  const FavoritesEmptyContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardContainer(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xffD3E3FD),
              maxRadius: 30,
              child: Icon(Icons.star, color: Colors.orange, size: 40),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Accede rápidamente a tus personas favoritas',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500, height: 1.3),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Añade personas a Favoritos para que te resulte más fácil encontrarlas y contactar con ellas',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        OutlinedButton(
          onPressed: () {},
          style: ButtonStyle(
              minimumSize: const MaterialStatePropertyAll(Size.fromHeight(50)),
              overlayColor: MaterialStatePropertyAll(Colors.grey[400]),
              backgroundColor:
                  const MaterialStatePropertyAll(Color(0xffC2E7FF))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add,
                color: Colors.black87,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Añadir favoritos',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
