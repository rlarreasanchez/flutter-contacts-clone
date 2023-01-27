import 'package:contactos_app/contacts/screens/config_screen.dart';
import 'package:contactos_app/contacts/screens/contacts_screen.dart';
import 'package:contactos_app/contacts/screens/favorites_screen.dart';
import 'package:contactos_app/home/components/animated_button.dart';
import 'package:contactos_app/home/models/tab_item_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<TabItemModel> _items = [
    TabItemModel('Contactos', Icons.person_outline, Icons.person),
    TabItemModel('Favoritos', Icons.favorite_outline, Icons.favorite),
    TabItemModel('Configuración', Icons.settings_outlined, Icons.settings),
  ];

  static final List<Widget> _screens = [
    const ContactsScreen(),
    const FavoritesScreen(),
    const ConfigScreen()
  ];

  List<BottomNavigationBarItem> getBottomTabs(List<TabItemModel> tabs) {
    return tabs
        .asMap()
        .entries
        .map((entry) => BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: AnimatedButton(
                  width: 70,
                  height: 35,
                  onPress: () {
                    _onItemTapped(entry.key);
                  },
                  isSelected: _selectedIndex == entry.key,
                  unselectedWidget:
                      Icon(entry.value.icon, color: Colors.black45),
                  selectedWidget:
                      Icon(entry.value.activeIcon, color: Colors.black),
                ),
              ),
              label: entry.value.title,
            ))
        .toList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _screens[_selectedIndex],
          bottomNavigationBar: SizedBox(
            height: 90,
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                items: getBottomTabs(_items),
                currentIndex: _selectedIndex,
                selectedLabelStyle:
                    const TextStyle(fontSize: 16, color: Colors.black),
                selectedItemColor: Colors.black,
                onTap: _onItemTapped,
                unselectedFontSize: 16,
                backgroundColor: const Color(0xffF2F5FB),
              ),
            ),
          ),
        ));
  }
}
