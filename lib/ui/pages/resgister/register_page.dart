import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController? _controller;
  bool validation = false;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _validatioName(String? value) {
    if (_controller!.text.isNotEmpty) {
      setState(() {
        validation = true;
      });
    } else {
      setState(() {
        validation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: validation
          ? FloatingActionButton(
              child: const Icon(Icons.send_rounded),
              onPressed: () {
                if (_controller!.text.isNotEmpty) {
                  Get.toNamed("/chat", arguments: {'nick': _controller?.text});
                }
              })
          : null,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  child: TextFormField(
                    style: Theme.of(context).textTheme.titleLarge,
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Digite um nome",
                      labelStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                    onChanged: _validatioName,
                    autofocus: true,
                    onEditingComplete: () {
                      if (_controller!.text.isNotEmpty) {
                        Get.toNamed("/chat",
                            arguments: {'nick': _controller?.text});
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
