import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/sensor_model.dart';
import 'package:grd_proj/screens/sensor_edit.dart';

// ignore: must_be_immutable
class SensorView extends StatelessWidget {
  final SensorDevice sensor;
  SensorView({super.key, required this.sensor});
  bool tell = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Image.asset(
                'assets/images/Group.png',
              ),
              const SizedBox(
                width: 20,
              ),
              Text(sensor.name,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    color: primaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  )),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.read<FieldBloc>().add(OpenFarmSensorUnitsEvent(farmId: sensor.farmId));
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close_rounded,
                    color: Color(0xff757575), size: 24),
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Text('Sensor Details',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Color(0xFF616161),
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  )),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SensorEdit(
                              sensorId: sensor.id,
                              farm: sensor.farmId,
                              field: sensor.fieldId,
                            )),
                  );
                },
                child: Container(
                  width: 99,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF616161),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/edit.png',
                          height: 20,
                          width: 20,
                          color: const Color(0xFF616161),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF616161),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Text('Status: ',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
              Container(
                width: 77,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: borderColor, width: 1)),
                child: Center(
                  child: Text(
                    tell ? "Active" : "Inactive",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                "Type: ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const Text(
                "combined sensor",
                style: TextStyle(
                    color: borderColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Field & Location ",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/location.png',
                  ),
                  const SizedBox(width: 8),
                  Text(
                    sensor.fieldName,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Serial Number",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/ha4tag.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    sensor.serialNumber,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Firmware Version",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/Group.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    sensor.firmWareVersion,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "IP Address",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/material-symbols-light_wifi.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    sensor.ipAddress ?? "Not Exist",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "MAC Address",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/material-symbols-light_wifi (1).png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    sensor.macAddress,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Configuration",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/Group.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  const SizedBox(
                    width: 300,
                    child: Text(
                      "Humidity, temperature, soil moisture sensors",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Power Rating",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/material-symbols-light_electric-bolt-outline-rounded.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "3.3v / 0.5W",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Last Maintenance",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/Vector2.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    sensor.lastMaintenance == null
                        ? "Not Exist"
                        : sensor.lastMaintenance!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Next Maintenance",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/calender.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    sensor.nextMaintenance == null
                        ? "Not Exist"
                        : sensor.nextMaintenance!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Battery Level",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/battery.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 90,
                    height: 10,
                    child: LinearProgressIndicator(
                      value: sensor.batteryLevel! / 100,
                      backgroundColor: const Color.fromARGB(63, 97, 97, 97),
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${sensor.batteryLevel}%",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Added By",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/person_icon.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          sensor.addedBy,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ]),
            ),
            const Divider(
              color: borderColor,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Last Reading",
                  style: TextStyle(
                      color: Color(0xFF616161),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: 400,
                    height: 160,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(63, 159, 159, 159),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 120,
                              height: 104,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/water-outline.png',
                                      height: 24,
                                      width: 24,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                        "${sensor.moisture!.toStringAsFixed(2)}%",
                                        style: const TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "manrope",
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("Moisture",
                                        style: TextStyle(
                                          color: Color(0xFF757575),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "manrope",
                                        )),
                                  ])),
                          Container(
                              width: 120,
                              height: 104,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/temp2.png',
                                      // height: 24,
                                      // width: 24,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                        "${sensor.temperature!.toStringAsFixed(2)}°C",
                                        style: const TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "manrope",
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("Temp",
                                        style: TextStyle(
                                          color: Color(0xFF757575),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "manrope",
                                        )),
                                  ])),
                          Container(
                              width: 120,
                              height: 104,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/Hum.png',
                                      // height: 24,
                                      // width: 24,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                        "${sensor.humidity!.toStringAsFixed(2)}°C",
                                        style: const TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "manrope",
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("Humidity",
                                        style: TextStyle(
                                          color: Color(0xFF757575),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "manrope",
                                        )),
                                  ]))
                        ]))
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
