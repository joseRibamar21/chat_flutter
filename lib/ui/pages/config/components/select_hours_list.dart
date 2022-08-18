import 'package:flutter/material.dart';

class SelectHoursList extends StatefulWidget {
  const SelectHoursList({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectHoursList> createState() => _SelectHoursListState();
}

class _SelectHoursListState extends State<SelectHoursList> {
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
    return SizedBox(
      height: 150,
      width: 100,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        magnification: 1.2,
        diameterRatio: 1.5,
        onSelectedItemChanged: (value) {},
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
  }
}
