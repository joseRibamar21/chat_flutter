import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController? _controller;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Text("Digite seu um nome!",
                style: Theme.of(context).textTheme.titleMedium),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _controller,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    if (_controller!.text.isNotEmpty) {
                      Get.toNamed("/chat",
                          arguments: {'nick': _controller?.text});
                    }
                  },
                  child: const Text("Confirmar")),
            ),
            const SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  const Divider(),
                  Text(
                      "Para aumentar sua segurança, tenha cadastrado uma biometria em seu celular!",
                      style: Theme.of(context).textTheme.bodySmall)
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
