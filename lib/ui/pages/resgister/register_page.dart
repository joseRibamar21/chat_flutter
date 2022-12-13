import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../mixins/mixins.dart';
import 'components/components.dart';
import 'register.dart';

class RegisterPage extends StatefulWidget {
  final RegisterPresenter presenter;
  const RegisterPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with NavigationManager, UIErrorManager {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => widget.presenter,
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return SafeArea(
              child: Builder(
                builder: (context) {
                  widget.presenter.inicialization();
                  return Column(
                    children: [
                      Expanded(
                          flex: 15,
                          child: SizedBox(
                            child: PageView(
                              controller: pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                RegisterSetp1(pageController: pageController),
                                const RegisterSetp2()
                              ],
                            ),
                          )),
                      Expanded(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 2,
                          effect: const WormEffect(
                              radius: 8,
                              spacing: 10,
                              dotHeight: 12,
                              dotWidth: 12,
                              activeDotColor: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class RegisterSetp1 extends StatelessWidget {
  final PageController pageController;
  const RegisterSetp1({
    required this.pageController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<RegisterPresenter>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text("Insira um codinome para utilizar a aplicação!",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Codinome",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            TextFieldRegister(onConfirm: () {}),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: StreamBuilder<String?>(
                  stream: presenter.nameErrorStream,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: snapshot.data == null &&
                              snapshot.connectionState == ConnectionState.active
                          ? () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.bounceInOut);
                            }
                          : null,
                      child: const Text("Proximo"),
                    );
                  }),
            ),
            const SizedBox(height: 90),
            const Divider(),
            Text(
                "Para aumentar sua segurança, tenha cadastrado uma biometria em seu celular!",
                style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
    );
  }
}

class RegisterSetp2 extends StatelessWidget {
  const RegisterSetp2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text("Insira uma senha numérica para utilizar o bloqueador do app!",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child:
                  Text("Senha", style: Theme.of(context).textTheme.titleMedium),
            ),
            TextPasswordFieldRegister(onConfirm: () {}),
            const SizedBox(height: 90),
            const Center(child: RegisterButtonLogin()),
          ],
        ),
      ),
    );
  }
}
