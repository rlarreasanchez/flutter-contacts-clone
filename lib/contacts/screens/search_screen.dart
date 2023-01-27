import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F5FB),
        body: Column(
          children: [
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colors.black12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Hero(
                                tag: 'backIcon',
                                child: Icon(Icons.arrow_back,
                                    size: 24, color: Colors.black45)),
                          ),
                        ),
                        const Expanded(
                          child: Hero(
                            tag: 'searchInput',
                            child: Material(
                              child: TextField(
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffF2F5FB),
                                  hintText: 'Buscar contactos',
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 0),
                                ),
                                autofocus: true,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
