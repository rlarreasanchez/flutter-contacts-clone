import 'package:contactos_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contact/screens/contact_screen.dart';
import 'package:contactos_app/features/contacts/screens/search_screen.dart';
import 'package:contactos_app/features/home/screens/home_screen.dart';

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
        title: 'ContactosApp',
        theme: appTheme,
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomeScreen(),
          'search': (context) => const SearchScreen(),
          'contact': (context) => ContactScreen(),
        });
  }
}
