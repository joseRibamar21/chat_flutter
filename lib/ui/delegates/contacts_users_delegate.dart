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
    return FutureBuilder<List<Contact>>(
      future: ContactsService.getContacts(
          query: query,
          withThumbnails: false,
          orderByGivenName: false,
          iOSLocalizedLabels: false,
          androidLocalizedLabels: false,
          photoHighResolution: false),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
                child: Text(
              "Aguarde...",
              style: Theme.of(context).textTheme.bodyLarge,
            ));

          case ConnectionState.none:
            return Center(
                child: Text(
              "Erro ao carregar dados.",
              style: Theme.of(context).textTheme.bodyLarge,
            ));

          case ConnectionState.done:
            contacts = contacts = snapshot.data!
                .map<Contact>((e) => e)
                .takeWhile((value) =>
                    value.givenName != null || value.givenName != "Error")
                .toList();
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
          style: Theme.of(context).textTheme.bodyMedium,
        ));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Contact>>(
      future: ContactsService.getContacts(
          query: query,
          withThumbnails: false,
          orderByGivenName: false,
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

  Widget initiList() {
    return FutureBuilder<List<Contact>>(
      future: ContactsService.getContacts(
          query: query,
          withThumbnails: false,
          orderByGivenName: false,
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

  /* List<Contact> _seachContact(String state, List<Contact> list) {
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
  } */
}
