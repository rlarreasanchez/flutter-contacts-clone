import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// El estado de nuestro StateNotifier debe ser inmutable.
// También podríamos usar paquetes como Freezed para ayudar con la implementación.
@immutable
class ContactsState {
  const ContactsState(
      {required this.errorMessage,
      required this.loading,
      required this.contacts});

  // Todas las propiedades deben ser `final` en nuestra clase.
  final List<Contact> contacts;
  final String errorMessage;
  final bool loading;

  // Como `Todo` es inmutable, implementamos un método que permite clonar el
  // `Todo` con un contenido ligeramente diferente.
  ContactsState copyWith(
      {List<Contact>? contacts, String? error, bool? loading}) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      errorMessage: error ?? errorMessage,
      loading: loading ?? this.loading,
    );
  }
}

class ContactsNotifier extends StateNotifier<ContactsState> {
  // Inicializamos la lista de `contactos` como una lista vacía
  ContactsNotifier()
      : super(const ContactsState(
            errorMessage: '', loading: false, contacts: []));

  void getContacts() async {
    state = state.copyWith(loading: true);
    try {
      final List<Contact> contacts =
          await ContactsService.getContacts(withThumbnails: false);

      state = state.copyWith(contacts: contacts, loading: false, error: '');
    } catch (e) {
      inspect(e);
      state = state.copyWith(
          contacts: [],
          loading: false,
          error: 'Fallo al cargar la lista de Contactos');
    }
  }
}

// Finalmente, estamos usando StateNotifierProvider para permitir que la
// interfaz de usuario interactúe con nuestra clase ContactsNotifier.
final contactsProvider =
    StateNotifierProvider<ContactsNotifier, ContactsState>((ref) {
  return ContactsNotifier();
});
