import 'package:flutter/material.dart';

class SelectHoursList extends StatefulWidget {
  final Function(int value) getHours;
  final double initialHours;
  const SelectHoursList(
      {Key? key, required this.getHours, required this.initialHours})
      : super(key: key);

  @override
  State<SelectHoursList> createState() => _SelectHoursListState();
}

class _SelectHoursListState extends State<SelectHoursList> {
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

  final List<String> _hours = List.generate(
    12,
    ((index) {
      if (index < 9) {
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
        _scrollController.animateTo(50 * widget.initialHours,
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
          onSelectedItemChanged: (value) => widget.getHours.call(value),
          physics:
              const FixedExtentScrollPhysics(parent: BouncingScrollPhysics()),
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: _hours.length,
            builder: (BuildContext context, int index) {
              return Center(
                child: Text(
                  _hours[index],
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
