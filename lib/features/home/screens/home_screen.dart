import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contactos_app/features/home/widgets/animated_button.dart';
import 'package:contactos_app/features/home/models/tab_item_model.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
// import 'package:contactos_app/features/config/screens/config_screen.dart';
import 'package:contactos_app/features/contacts/screens/contacts_screen.dart';
import 'package:contactos_app/features/favorites/screens/favorites_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  static final List<TabItemModel> _items = [
    TabItemModel('Contactos', Icons.person_outline, Icons.person),
    TabItemModel('Favoritos', Icons.favorite_outline, Icons.favorite),
    // TabItemModel('Configuración', Icons.settings_outlined, Icons.settings),
  ];

  static final List<Widget> _screens = [
    const ContactsScreen(),
    const FavoritesScreen(),
    // const ConfigScreen()
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
  void initState() {
    super.initState();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    } else {
      ref.read(contactsProvider.notifier).getContacts();
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      const snackBar =
          SnackBar(content: Text('Acceso a los Contactos denegado'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      const snackBar = SnackBar(
          content:
              Text('Los Contactos no están habilitados en el dispositivo'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(255, 227, 230, 234),
                        width: 1.0))),
            child: BottomNavigationBar(
              items: getBottomTabs(_items),
              currentIndex: _selectedIndex,
              selectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w500),
              selectedItemColor: Colors.black,
              onTap: _onItemTapped,
              unselectedFontSize: 16,
              backgroundColor: const Color(0xffF2F5FB),
            ),
          ),
        ),
      ),
    );
  }
}
