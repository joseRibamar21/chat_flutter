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
                                RegisterSetp0(pageController: pageController),
                                RegisterSetp1(pageController: pageController),
                                const RegisterSetp2()
                              ],
                            ),
                          )),
                      Expanded(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
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
