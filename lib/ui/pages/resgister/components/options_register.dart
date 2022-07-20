import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register.dart';

class OptionsRegister extends StatelessWidget {
  const OptionsRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              constrain.maxWidth > 1100 ? const _Option1() : const _Option2());
    });
  }
}

class _Option1 extends StatelessWidget {
  const _Option1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<RegisterController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 300,
          width: 500,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Digite Insira o link da sala!",
                    style: Theme.of(context).textTheme.titleMedium),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: SizedBox(
                    height: 60,
                    width: 500,
                    child: TextFieldRegister(
                        onConfirm: () {}, onChange: (value) {}),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        bool test = false;
                      },
                      child: const Text("Confirmar")),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 400, child: VerticalDivider()),
        SizedBox(
          height: 300,
          width: 500,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Gere uma nova sala!"),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {}, child: const Text("Confirmar")),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Option2 extends StatelessWidget {
  const _Option2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<RegisterController>(context);
    return Column(
      children: [
        SizedBox(
          height: 300,
          width: 500,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Digite Insira o link da sala!",
                    style: Theme.of(context).textTheme.titleMedium),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: SizedBox(
                    height: 60,
                    width: 500,
                    child: TextFieldRegister(
                        onConfirm: () {}, onChange: (value) {}),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        bool test = false;
                      },
                      child: const Text("Confirmar")),
                )
              ],
            ),
          ),
        ),
        const Divider(),
        SizedBox(
          height: 300,
          width: 500,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Gere uma nova sala!"),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {}, child: const Text("Confirmar")),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
