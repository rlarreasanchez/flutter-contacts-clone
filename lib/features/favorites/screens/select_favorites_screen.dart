import 'dart:async';

import 'package:contactos_app/features/favorites/widgets/select_favorites_sticky_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteTermProvider = StateProvider.autoDispose((ref) => '');
final isSearchingProvider = StateProvider.autoDispose((ref) => false);

class SelectFavoritesScreen extends ConsumerWidget {
  const SelectFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSearchInput = ref.watch(isSearchingProvider);

    return Stack(children: [
      Scaffold(
          backgroundColor: const Color(0xffF2F5FB),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: showSearchInput
                ? const _SearchingAppBar()
                : const _DefaultAppBar(),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Expanded(child: SelectFavoritesStickyList())],
            ),
          )),
    ]);
  }
}

class _DefaultAppBar extends ConsumerWidget {
  const _DefaultAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text(
        'Seleccionar contactos',
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        IconButton(
          onPressed: () {
            ref.read(favoriteTermProvider.notifier).state = '';
            ref.read(isSearchingProvider.notifier).state = true;
          },
          icon: const Icon(Icons.search),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}

class _SearchingAppBar extends ConsumerWidget {
  const _SearchingAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      surfaceTintColor: Colors.grey[300],
      backgroundColor: Colors.grey[300],
      elevation: 0.0,
      title: const _SearchInput(),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          ref.read(isSearchingProvider.notifier).state = false;
        },
      ),
    );
  }
}

class _SearchInput extends ConsumerStatefulWidget {
  const _SearchInput({
    Key? key,
  }) : super(key: key);

  @override
  _SearchHeaderInputState createState() => _SearchHeaderInputState();
}

class _SearchHeaderInputState extends ConsumerState<_SearchInput> {
  Timer? _debounce;

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(favoriteTermProvider.notifier).state = query;
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
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            hintText: 'Buscar contactos',
            hintStyle: const TextStyle(color: Colors.black54),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          ),
          autofocus: true,
          autocorrect: false,
        ),
      ),
    );
  }
}
