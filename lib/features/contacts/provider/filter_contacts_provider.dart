import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class FilterContactsState {
  const FilterContactsState({
    required this.byPhone,
    required this.byEmail,
  });

  final bool byPhone;
  final bool byEmail;

  FilterContactsState copyWith({
    bool? byPhone,
    bool? byEmail,
  }) {
    return FilterContactsState(
      byPhone: byPhone ?? this.byPhone,
      byEmail: byEmail ?? this.byEmail,
    );
  }
}

class FilterContactsNotifier extends StateNotifier<FilterContactsState> {
  FilterContactsNotifier(ref)
      : super(const FilterContactsState(
          byPhone: false,
          byEmail: false,
        ));

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
}

final filterContactsProvider =
    StateNotifierProvider<FilterContactsNotifier, FilterContactsState>((ref) {
  return FilterContactsNotifier(ref);
});
