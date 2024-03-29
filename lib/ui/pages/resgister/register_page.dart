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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Text("Digite seu nick!",
                style: Theme.of(context).textTheme.titleMedium),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: _controller,
                    onEditingComplete: () {
                      if (_controller!.text.isNotEmpty) {
                        Get.toNamed("/chat",
                            arguments: {'nick': _controller?.text});
                      }
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_controller!.text.isNotEmpty) {
                    Get.toNamed("/chat",
                        arguments: {'nick': _controller?.text});
                  }
                },
                child: const Text("Confirmar"))
          ],
        ),
      ),
    );
  }
}
