import 'package:flutter/material.dart';

class SelectMinutesList extends StatefulWidget {
  final Function(int value) getMinutes;
  final double initialMinutes;
  const SelectMinutesList(
      {Key? key, required this.getMinutes, required this.initialMinutes})
      : super(key: key);

  @override
  State<SelectMinutesList> createState() => _SelectMinutesListState();
}

class _SelectMinutesListState extends State<SelectMinutesList> {
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    _scrollController = FixedExtentScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final List<String> _minutes = List.generate(
    60,
    ((index) {
      if (index < 10) {
        return "0$index";
      } else {
        return (index).toString();
      }
    }),
  );

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _scrollController.animateTo(50 * widget.initialMinutes,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.bounceInOut);
      });
      return SizedBox(
        height: 150,
        width: 100,
        child: ListWheelScrollView.useDelegate(
          controller: _scrollController,
          itemExtent: 50,
          magnification: 1.2,
          diameterRatio: 1.5,
          overAndUnderCenterOpacity: 0.4,
          onSelectedItemChanged: ((value) => widget.getMinutes.call(value)),
          physics:
              const FixedExtentScrollPhysics(parent: BouncingScrollPhysics()),
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: _minutes.length,
            builder: (BuildContext context, int index) {
              return Center(
                child: Text(
                  _minutes[index],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
