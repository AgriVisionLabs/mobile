// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/irrigation_model.dart';
import 'package:grd_proj/screens/irrigation_edit.dart';
import 'package:intl/intl.dart';

class IrrigationView extends StatelessWidget {
  final IrrigationDevice irrigationDevice;
  IrrigationView({super.key, required this.irrigationDevice});

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
                height: 30,
                width: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(irrigationDevice.name,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    color: primaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  )),
              const Spacer(),
              IconButton(
                onPressed: () {
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
              const Text('Irrigation Unit Details',
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
                        builder: (context) => IrrigationEdit(
                              farm: irrigationDevice.farmId,
                              field: irrigationDevice.fieldId,
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
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: borderColor, width: 1)),
                child: Center(
                  child: Text(
                    irrigationDevice.status == 0
                        ? "Active"
                        : irrigationDevice.status == 1
                            ? "Inactive"
                            : "Mantenance",
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
                "Spinkler",
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
                    irrigationDevice.fieldName,
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
                    irrigationDevice.serialNumber,
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
                    irrigationDevice.firmWareVersion,
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/material-symbols-light_wifi.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          irrigationDevice.ipAddress ?? "Not Exist",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ]),
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
                    irrigationDevice.macAddress,
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/Group.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "8 zones, 360° coverage",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ]),
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
                    irrigationDevice.lastMaintenance == null
                        ? "Not Exist"
                        : DateFormat('MMM dd, yyyy')
                            .format(irrigationDevice.lastMaintenance!),
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
                    irrigationDevice.nextMaintenance == null
                        ? "Not Exist"
                        : DateFormat('MMM dd, yyyy')
                            .format(irrigationDevice.nextMaintenance!),
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
                      value: 85 / 100,
                      backgroundColor: const Color.fromARGB(63, 97, 97, 97),
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "85%",
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
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/person_icon.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "person",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
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
                  "Last Operation",
                  style: TextStyle(
                      color: Color(0xFF616161),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  width: 380,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(63, 159, 159, 159),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Zone 3 active for 20 minutes",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Last Updated: ${DateFormat('MMM dd, yyyy').format(irrigationDevice.lastUpdated)} at ${DateFormat('HH :MM').format(irrigationDevice.lastUpdated)}",
                          style: const TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                )
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
