import 'package:flutter/material.dart';

import '../components/components.dart';

class AlterTimerPage extends StatefulWidget {
  const AlterTimerPage({Key? key}) : super(key: key);

  @override
  State<AlterTimerPage> createState() => _AlterTimerPageState();
}

class _AlterTimerPageState extends State<AlterTimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alterar Tempo")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Horas",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "Minutos",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(
            height: 150,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Theme.of(context).cardColor.withOpacity(0.4),
                    width: double.maxFinite,
                    height: 40,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [SelectHoursList(), SelectMinutesList()],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
