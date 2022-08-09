import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../data/usecase/usecase.dart';
import '../../components/components.dart';
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
    with NavigationManager, KeyboardManager, WidgetsBindingObserver {
  final BlockAuthController _authController = BlockAuthController();
  final AuthenticationLocal _authenticationLocal = AuthenticationLocal();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Future.delayed(const Duration(milliseconds: 40)).then((value) async {
          if (await _authenticationLocal.varifyCanAuthentican()) {
            _authController.verify(true);
          }
        });
        break;
      default:
    }
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => widget.presenter,
      child: WillPopScope(
        onWillPop: () async {
          return await showDialogReturn(context, "Deseja sair do app?");
        },
        child: BlockAuth(
          validadePassword: widget.presenter.validadePassword,
          controller: _authController,
          body: Scaffold(
            appBar: AppBar(
                title: HomeAppBar(
              presenter: widget.presenter,
            )),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  /* List<Contact> contacts = await ContactsService.getContacts();
                  try {
                    var t = await showSearch(
                        context: context,
                        delegate: CitiesDelegate(contacts: contacts));
                    print(t!.toMap());
                  } catch (error) {
                    print(error);
                  }
                  print(contacts.toString()); */
                },
                child: const Icon(Icons.contacts_rounded)),
            body: Builder(builder: (_) {
              widget.presenter.inicialization();

              Future.delayed(const Duration(milliseconds: 100),
                  widget.presenter.loadRooms);
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
      ),
    );
  }
}
