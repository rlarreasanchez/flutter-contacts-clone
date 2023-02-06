import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
import 'package:contactos_app/features/contacts/widgets/contact_item.dart';
import 'package:contactos_app/shared/utils/utils.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTermProvider = StateProvider.autoDispose((ref) => '');

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTerm = ref.watch(searchTermProvider);
    final contactsState = ref.watch(contactsProvider);

    List<Widget> filterContactList(List<Contact> contactos) {
      // TODO: Si no hay searchTerm debe de devolver historial del storage
      if (searchTerm.isEmpty) return [];
      return contactos
          .where((contacto) =>
              Utils.containsStringTerm(
                  contacto.displayName ?? '', searchTerm) ||
              Utils.containsListTerm(
                  contacto.emails!.map((email) => email.value ?? '').toList(),
                  searchTerm))
          .map((c) => FadeIn(
                child: ContactItem(
                  contact: c,
                  highlight: true,
                  highlightText: searchTerm,
                ),
              ))
          .toList();
    }

    return Scaffold(
        backgroundColor: const Color(0xffF2F5FB),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _SearchHeader(),
              Expanded(
                  child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    sliver: SliverToBoxAdapter(
                        child: Column(
                      children: [...filterContactList(contactsState.contacts)],
                    )),
                  )
                ],
              ))
            ],
          ),
        ));
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
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
                  child:
                      Icon(Icons.arrow_back, size: 24, color: Colors.black45)),
            ),
          ),
          const Expanded(
            child: _SearchHeaderInput(),
          )
        ],
      ),
    );
  }
}

class _SearchHeaderInput extends ConsumerStatefulWidget {
  const _SearchHeaderInput({
    Key? key,
  }) : super(key: key);

  @override
  _SearchHeaderInputState createState() => _SearchHeaderInputState();
}

class _SearchHeaderInputState extends ConsumerState<_SearchHeaderInput> {
  Timer? _debounce;

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchTermProvider.notifier).state = query;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'searchInput',
      child: Material(
        child: TextField(
          onChanged: _onSearchChanged,
          style: const TextStyle(fontSize: 18, color: Colors.black54),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xffF2F5FB),
            hintText: 'Buscar contactos',
            hintStyle: TextStyle(color: Colors.black54),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          ),
          autofocus: true,
          autocorrect: false,
        ),
      ),
    );
  }
}
