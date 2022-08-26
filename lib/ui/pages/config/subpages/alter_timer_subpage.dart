import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/components.dart';
import '../components/components.dart';
import '../config.dart';

class AlterTimerPage extends StatefulWidget {
  final Map<String, dynamic> mapTime;
  const AlterTimerPage({Key? key, required this.mapTime}) : super(key: key);

  @override
  State<AlterTimerPage> createState() => _AlterTimerPageState();
}

class _AlterTimerPageState extends State<AlterTimerPage> {
  @override
  Widget build(BuildContext context) {
    var presenter = Get.find<ConfigPresenter>();
    int hours = 0;
    int minutes = 0;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Alterar Tempo"),
          elevation: 0,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Altere o tempo padrão das salas"),
              SizedBox(
                  child: Column(
                children: [
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
                          children: [
                            SelectHoursList(
                                initialHours: widget.mapTime['h'],
                                getHours: (value) => hours = value),
                            SelectMinutesList(
                              initialMinutes: widget.mapTime['m'],
                              getMinutes: (value) => minutes = value,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    await presenter.updateTime(hours, minutes);
                    showToastGreatMenssage("Salvo com sucesso");
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  child: const Text("Salvar"),
                ),
              )
            ]),
      ),
    );
  }
}
