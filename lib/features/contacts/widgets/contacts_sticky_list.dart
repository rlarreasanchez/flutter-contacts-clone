import 'package:contactos_app/features/contacts/provider/filter_contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contactos_app/features/contacts/provider/contacts_provider.dart';
import 'package:contactos_app/features/contacts/utils/contacts_utils.dart';
import 'package:contactos_app/features/contact/models/contact_model.dart';
import 'package:contactos_app/features/contacts/models/contact_list_item_model.dart';
import 'package:contactos_app/features/contacts/widgets/contacts_widgets.dart';

class ContactsStickyList extends ConsumerWidget {
  final ScrollController _controller = ScrollController();

  ContactsStickyList({
    Key? key,
  }) : super(key: key);

  List<ContactsStickySliver> generateContactsSlivers(
      List<ContactModel> contactos, ScrollController controller) {
    final List<ContactListItemModel> contactosList =
        ContactsUtils.getContactsStickyList(contactos);

    return contactosList
        .asMap()
        .entries
        .map((contact) => ContactsStickySliver(
            index: contact.key,
            item: contact.value,
            scrollController: controller))
        .toList();
  }

  List<ContactModel> getFilteredContacts(
      List<ContactModel> contacts, FilterContactsState filter) {
    List<ContactModel> contactsFiltered = [...contacts];
    if (filter.byPhone) {
      contactsFiltered = contactsFiltered
          .where((contact) => contact.phonesSanitized.isNotEmpty)
          .toList();
    }
    if (filter.byEmail) {
      contactsFiltered = contactsFiltered
          .where((contact) => contact.emailsSanitized.isNotEmpty)
          .toList();
    }

    return contactsFiltered;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsStateRef = ref.watch(contactsProvider);
    final filter = ref.watch(filterContactsProvider);

    if (contactsStateRef.loading && contactsStateRef.contacts.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    if (contactsStateRef.errorMessage.isNotEmpty) {
      return Center(child: Text(contactsStateRef.errorMessage));
    }

    return DraggableScrollbar(
      heightScrollThumb: 70.0,
      offsetHeight: 20,
      controller: _controller,
      contactsModels: ContactsUtils.getContactsStickyList(
          getFilteredContacts(contactsStateRef.contacts, filter)),
      child: _RefreshContactsIndicator(
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            _ContactsListHeader(
                title: 'Contactos',
                nContacts: contactsStateRef.contacts.length),
            ...generateContactsSlivers(
                getFilteredContacts(contactsStateRef.contacts, filter),
                _controller)
          ],
        ),
      ),
    );
  }
}

class _ContactsListHeader extends StatelessWidget {
  final String title;
  final int nContacts;

  const _ContactsListHeader({
    Key? key,
    required this.title,
    required this.nContacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        padding: const EdgeInsets.only(left: 25.0, bottom: 18, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.person_outline,
              size: 20,
              color: Colors.black87,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                '$title · $nContacts contactos',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}

class _RefreshContactsIndicator extends ConsumerWidget {
  final Widget child;

  const _RefreshContactsIndicator({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        return ref.read(contactsProvider.notifier).getContacts();
      },
      child: child,
    );
  }
}
