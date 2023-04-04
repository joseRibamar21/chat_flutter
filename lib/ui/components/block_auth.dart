import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/usecase/autentication_local.dart';

class BlockAuthController extends GetxController {
  final _rxBlock = Rx<bool>(false);

  Stream<bool> get blockStream => _rxBlock.stream;

  void block() {
    _rxBlock.value = true;
  }

  void verify(bool value) {
    _rxBlock.value = value;
  }
}

class BlockAuth extends StatefulWidget {
  final bool Function(String password) validadePassword;
  final BlockAuthController controller;
  final Widget body;
  const BlockAuth(
      {Key? key,
      required this.controller,
      required this.body,
      required this.validadePassword})
      : super(key: key);

  @override
  State<BlockAuth> createState() => _BlockAuthState();
}

class _BlockAuthState extends State<BlockAuth> {
  AuthenticationLocal authLocal = AuthenticationLocal();
  var block = false;
  var flagBlock = true;

  Future<void> testeFinger() async {
    block = await authLocal.varifyAuthentican();
    widget.controller.verify(block);
  }

  String? _testePassword(String password) {
    if (widget.validadePassword.call(password)) {
      widget.controller.verify(false);
      return null;
    }
    return "Senha incorreta!";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.body,
        Builder(builder: (context) {
          return StreamBuilder<bool>(
              stream: widget.controller.blockStream,
              builder: (context, snapshot) {
                block = snapshot.data ?? false;
                flagBlock = block;
                if (block) {
                  if (flagBlock) {
                    testeFinger();
                    flagBlock = false;
                  }
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: AnimatedContainer(
                      height: block ? double.maxFinite : 0,
                      width: block ? double.maxFinite : 0,
                      duration: const Duration(milliseconds: 300),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black12, Colors.black26],
                        ),
                      ),
                      child: SafeArea(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Senha do App',
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: PasswordNumberWidget(
                                    validade: _testePassword),
                              )),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: ElevatedButton.icon(
                                  onPressed: testeFinger,
                                  icon: const Icon(Icons.fingerprint),
                                  label: const Text(
                                    'Tentar novamente',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              });
        })
      ],
    );
  }
}

class PasswordNumberWidget extends StatefulWidget {
  final String? Function(String password) validade;
  const PasswordNumberWidget({Key? key, required this.validade})
      : super(key: key);

  @override
  State<PasswordNumberWidget> createState() => PasswordNumberWidgetState();
}

class PasswordNumberWidgetState extends State<PasswordNumberWidget> {
  List<int> password = [];
  String passwordView = "";
  String? errorText;
  void _tapKeyboard(int value) {
    switch (value) {
      case -2:
        errorText = widget.validade(passwordView.replaceAll(" ", ""));
        break;
      case -1:
        password.removeLast();
        break;
      default:
        if (password.length < 6) {
          password.add(value);
        }
    }

    passwordView = "";
    for (var element in password) {
      passwordView = "$passwordView$element ";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 4),
          child: SizedBox(
            width: 300,
            height: 100,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                    child: Text(
                  passwordView,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge!.color,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
        ),
        _ErrorTextPassword(errorText: errorText),
        const SizedBox(height: 30),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ButtonNumberKeyboardText(
                    f: () => _tapKeyboard(1),
                    t: "1",
                  ),
                  _ButtonNumberKeyboardText(
                    f: () => _tapKeyboard(2),
                    t: "2",
                  ),
                  _ButtonNumberKeyboardText(
                    f: () => _tapKeyboard(3),
                    t: "3",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ButtonNumberKeyboardText(
                    f: () => _tapKeyboard(4),
                    t: "4",
                  ),
                  _ButtonNumberKeyboardText(
                    f: () => _tapKeyboard(5),
                    t: "5",
                  ),
                  _ButtonNumberKeyboardText(
                    f: () => _tapKeyboard(6),
                    t: "6",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ButtonNumberKeyboardText(
                    f: () => _tapKeyboard(7),
                    t: "7",
                  ),
                  _ButtonNumberKeyboardText(
                    f: () => _tapKeyboard(8),
                    t: "8",
                  ),
                  _ButtonNumberKeyboardText(
                    f: () => _tapKeyboard(9),
                    t: "9",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ButtonNumberKeyboardIcon(
                    f: () => _tapKeyboard(-1),
                    t: Icons.backspace_rounded,
                  ),
                  _ButtonNumberKeyboardText(
                    f: () => _tapKeyboard(0),
                    t: "0",
                  ),
                  _ButtonNumberKeyboardIcon(
                    f: () => _tapKeyboard(-2),
                    t: Icons.done_rounded,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ErrorTextPassword extends StatelessWidget {
  final String? errorText;

  const _ErrorTextPassword({required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Text(
      errorText ?? "",
      style: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 16,
          decoration: TextDecoration.none),
    );
  }
}

class _ButtonNumberKeyboardText extends StatelessWidget {
  final Function() f;
  final String t;
  const _ButtonNumberKeyboardText({Key? key, required this.f, required this.t})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        elevation: 10,
        color: Colors.grey.withOpacity(0.5),
        child: InkWell(
          splashColor: Theme.of(context).primaryColor,
          onTap: f,
          child: SizedBox(
              width: 70,
              height: 70,
              child: Center(
                child: Text(
                  t,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge!.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              )),
        ),
      ),
    );
  }
}

class _ButtonNumberKeyboardIcon extends StatelessWidget {
  final Function() f;
  final IconData t;
  const _ButtonNumberKeyboardIcon({Key? key, required this.f, required this.t})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        elevation: 10,
        color: Colors.grey.withOpacity(0.5),
        child: InkWell(
          splashColor: Theme.of(context).primaryColor,
          onTap: f,
          child: SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: Icon(
                  t,
                ),
              )),
        ),
      ),
    );
  }
}
