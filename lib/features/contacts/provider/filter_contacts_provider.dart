import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class FilterContactsState {
  const FilterContactsState({
    required this.byPhone,
    required this.byEmail,
    required this.company,
  });

  final bool byPhone;
  final bool byEmail;
  final String company;

  FilterContactsState copyWith({
    bool? byPhone,
    bool? byEmail,
    String? company,
  }) {
    return FilterContactsState(
        byPhone: byPhone ?? this.byPhone,
        byEmail: byEmail ?? this.byEmail,
        company: company ?? this.company);
  }
}

class FilterContactsNotifier extends StateNotifier<FilterContactsState> {
  FilterContactsNotifier(ref)
      : super(const FilterContactsState(
            byPhone: false, byEmail: false, company: ''));

  void activeFilterByPhone() {
    state = state.copyWith(byPhone: true);
  }

  void activeFilterByEmail() {
    state = state.copyWith(byEmail: true);
  }

  void deactiveFilterByPhone() {
    state = state.copyWith(byPhone: false);
  }

  void deactiveFilterByEmail() {
    state = state.copyWith(byEmail: false);
  }

  void activeFilterCompany(String company) {
    state = state.copyWith(company: company);
  }

  void deactiveFilterCompany() {
    state = state.copyWith(company: '');
  }
}

final filterContactsProvider =
    StateNotifierProvider<FilterContactsNotifier, FilterContactsState>((ref) {
  return FilterContactsNotifier(ref);
});
