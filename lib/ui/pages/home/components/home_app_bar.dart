import 'package:flutter/material.dart';

import '../home.dart';

class HomeAppBar extends StatefulWidget {
  final HomePresenter presenter;
  const HomeAppBar({Key? key, required this.presenter}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;

  late Widget _myWidgetAnimatio = Align(
    alignment: Alignment.centerLeft,
    child: IconButton(
        onPressed: () => widget.presenter.goTo("/config"),
        icon: const Icon(Icons.settings)),
  );
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      widget.presenter.seaching(isPlaying);
      if (isPlaying) {
        _animationController.forward();
        _myWidgetAnimatio = SizedBox(
          width: double.maxFinite,
          child: TextField(
            autofocus: true,
            onChanged: widget.presenter.filterRoom,
            decoration: const InputDecoration(hintText: 'Pesquisar ...'),
          ),
        );
      } else {
        _animationController.reverse();
        _myWidgetAnimatio = Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
              onPressed: () => widget.presenter.goTo("/config"),
              icon: const Icon(Icons.settings)),
        );
        widget.presenter.returnFilterRoom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              reverseDuration: const Duration(milliseconds: 250),
              transitionBuilder: ((child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  )),
              child: _myWidgetAnimatio,
            ),
          ),
          GestureDetector(
            onTap: _handleOnPressed,
            child: AnimatedIcon(
              icon: AnimatedIcons.search_ellipsis,
              semanticLabel: 'Show menu',
              progress: _animationController,
            ),
          )
        ],
      ),
    );
  }
}
/*     leading: IconButton(
                onPressed: presenter.goRegister,
                icon: const Icon(Icons.build)), */