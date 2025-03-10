import 'package:flutter/material.dart';

import '../Components/color.dart';
import '../models/alert.dart';

class AlertsBar extends StatefulWidget {
  const AlertsBar({super.key});

  @override
  State<AlertsBar> createState() => _AlertsBarState();
}

class _AlertsBarState extends State<AlertsBar> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Alerts & Notifications',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: "Manrope")),
      SizedBox(
          width: double.infinity,
          height: 184,
          child: Alerts().alerts.isNotEmpty
              ? ListView.builder(
                  itemCount: Alerts().alerts.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Dismissible(
                        direction: DismissDirection.horizontal,
                        onDismissed: (_) {
                          ///remove the current alert
                        },
                        key: Key(index.toString()),
                        background: const Icon(
                          Icons.delete,
                          color: borderColor,
                        ),
                        child: Container(
                            decoration:
                                const BoxDecoration(color: Color(0xFFFFFFFF)),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: Icon(
                                Icons.warning_amber_outlined,
                                color: Alerts().alerts[index].degree == 300 ?
                                Colors.red : Alerts().alerts[index].degree == 200 ?
                                Colors.yellow : Colors.blue,
                              ),
                              title: SizedBox(
                                width: 200,
                                child: Text(
                                  Alerts().alerts[index].alert,

                                ),
                              ),
                            )));
                  })
              : const SizedBox(
                  child: Center(
                  child: Text(
                    "No Alerts",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                )))
    ]);
  }
}

class Alerts {
  List<AlertItem> alerts = [
    AlertItem(
      degree: 300,alert: "Disease detected in sector B - Green Acres",),
    AlertItem(
        degree: 200, alert: "low soil moisture in sector c - sun set fields"),
    AlertItem(
        degree: 100, alert: "irrigation system maintenance due - valley view"),
    AlertItem(
        degree: 100, alert: "irrigation system maintenance due - valley view"),
    AlertItem(
        degree: 100, alert: "irrigation system maintenance due - valley view")
  ];
}
