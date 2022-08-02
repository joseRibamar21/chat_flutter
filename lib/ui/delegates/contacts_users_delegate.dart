import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

import '../components/components.dart';

class CitiesDelegate extends SearchDelegate<Contact?> {
  late List<Contact> contacts = [];

  CitiesDelegate({required this.contacts});

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
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Contact>? suggestion;
    if (contacts != null) {
      suggestion = _seachContact(query, contacts);
    }
    return ListView.builder(
      itemCount: suggestion?.length ?? 0,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => close(
            context,
            suggestion![index],
          ),
          title: Text(suggestion![index].givenName ?? '',
              style: Theme.of(context).textTheme.bodyText1),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Contact> suggestion = [];
    if (contacts != null) {
      suggestion = _seachContact(query, contacts);
    }
    return contacts == null
        ? initiList()
        : ListView.builder(
            itemCount: suggestion.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => close(
                  context,
                  suggestion[index],
                ),
                title: Text(suggestion[index].givenName ?? '',
                    style: Theme.of(context).textTheme.bodyText1),
              );
            },
          );
  }

  Widget initiList() {
    return FutureBuilder<List<Contact>>(
      future: ContactsService.getContacts(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
                child: Text(
              "Aguarde...",
              style: Theme.of(context).textTheme.bodyText1,
            ));
            break;
          case ConnectionState.none:
            return Center(
                child: Text(
              "Erro ao carregar dados.",
              style: Theme.of(context).textTheme.bodyText1,
            ));
            break;
          case ConnectionState.done:
            contacts = snapshot.data!;
            return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => close(
                      context,
                      snapshot.data![index],
                    ),
                    title: Text(snapshot.data![index].givenName ?? "Error",
                        style: Theme.of(context).textTheme.bodyText1),
                  );
                });
            break;
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
    if (state == null) {
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
