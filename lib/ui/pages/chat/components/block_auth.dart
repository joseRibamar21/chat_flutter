import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/usecase/autentication_local.dart';

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
  final BlockAuthController controller;
  final Widget body;
  const BlockAuth({Key? key, required this.controller, required this.body})
      : super(key: key);

  @override
  State<BlockAuth> createState() => _BlockAuthState();
}

class _BlockAuthState extends State<BlockAuth> {
  AuthenticationLocal authLocal = AuthenticationLocal();
  var block = false;
  var flagBlock = true;

  Future<void> teste() async {
    block = await authLocal.varifyAuthentican();
    widget.controller.verify(block);
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
                    teste();
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
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Ops! não foi possivel se autenticar',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  teste();
                                },
                                child: const Text(
                                  'Tentar novamente',
                                ),
                              )
                            ],
                          ),
                        )),
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
