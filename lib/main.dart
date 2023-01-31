import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/contacts/models/contact_model.dart';
import 'package:contactos_app/contacts/screens/contact_screen.dart';
import 'package:contactos_app/contacts/screens/search_screen.dart';
import 'package:contactos_app/home/screens/home_screen.dart';

final contactProvider = StateProvider<ContactModel?>((ref) => null);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contactos',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              elevation: 0, // This removes the shadow from all App Bars.
            )),
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomeScreen(),
          'search': (context) => const SearchScreen(),
          'contact': (context) => const ContactScreen(),
        });
  }
}
