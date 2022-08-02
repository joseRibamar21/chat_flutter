import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../delegates/delegates.dart';
import '../../mixins/mixins.dart';
import '../chat/components/components.dart';
import 'components/components.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage({super.key, required this.presenter});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with NavigationManager, KeyboardManager {
  /*  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        /* Navigator.of(context).pushNamed(routeName); */
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
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
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => widget.presenter,
      child: WillPopScope(
        onWillPop: () async {
          return await showDialogReturn(context, "Deseja sair do app?");
        },
        child: Scaffold(
          appBar: AppBar(
              title: HomeAppBar(
            presenter: widget.presenter,
          )),
          /*  floatingActionButton: FloatingActionButton(
              onPressed: () async {
                List<Contact> contacts = await ContactsService.getContacts();
                try {
                  var t = await showSearch(
                      context: context,
                      delegate: CitiesDelegate(contacts: contacts));
                  print(t!.toMap());
                } catch (error) {
                  print(error);
                }
                print(contacts.toString());
              },
              child: const Icon(Icons.contacts_rounded)), */
          body: Builder(builder: (_) {
            widget.presenter.inicialization();

            Future.delayed(
                const Duration(milliseconds: 100), widget.presenter.loadRooms);
            handleNaviationPush(widget.presenter.navigatorStream);
            return GestureDetector(
              onTap: () => hideKeyboard(context),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeUserName(),
                    const HomeListOptionsRooms(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        "Salas",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const RoomsListView()
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
