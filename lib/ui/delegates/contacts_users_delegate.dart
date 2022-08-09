import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsDelegate extends SearchDelegate<String> {
  late List<Contact> contacts = [];

  ContactsDelegate();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Contact>? suggestion;
    if (contacts.isNotEmpty) {
      suggestion = _seachContact(query, contacts);
    }
    return ListView.separated(
      itemCount: suggestion?.length ?? 0,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => close(
            context,
            suggestion![index].givenName ?? "",
          ),
          title: Text(suggestion![index].givenName ?? '',
              style: Theme.of(context).textTheme.titleSmall),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Contact> suggestion = [];
    if (contacts.isNotEmpty) {
      suggestion = _seachContact(query, contacts);
    }
    return contacts.isEmpty
        ? initiList()
        : ListView.separated(
            itemCount: suggestion.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => close(
                  context,
                  suggestion[index].givenName ?? "",
                ),
                title: Text(suggestion[index].givenName ?? '',
                    style: Theme.of(context).textTheme.titleSmall),
              );
            },
          );
  }

  Widget initiList() {
    return FutureBuilder<List<Contact>>(
      future: ContactsService.getContacts(
          iOSLocalizedLabels: false,
          androidLocalizedLabels: false,
          photoHighResolution: false),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
                child: Text(
              "Aguarde...",
              style: Theme.of(context).textTheme.bodyText1,
            ));

          case ConnectionState.none:
            return Center(
                child: Text(
              "Erro ao carregar dados.",
              style: Theme.of(context).textTheme.bodyText1,
            ));

          case ConnectionState.done:
            contacts = snapshot.data!;
            return ListView.separated(
                itemCount: contacts.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => close(
                      context,
                      snapshot.data![index].givenName ?? "",
                    ),
                    title: Text(snapshot.data![index].givenName ?? "Error",
                        style: Theme.of(context).textTheme.titleSmall),
                  );
                });
          default:
        }
        return Center(
            child: Text(
          "Erro ao carregar dados",
          style: Theme.of(context).textTheme.bodyText1,
        ));
      },
    );
  }

  List<Contact> _seachContact(String state, List<Contact> list) {
    if (state.isEmpty) {
      state = '';
    }
    List<Contact> resp = [];
    for (var i in list) {
      if (i.givenName!.toUpperCase().contains(state.toUpperCase())) {
        resp.add(i);
      }
    }
    return resp;
  }
}
