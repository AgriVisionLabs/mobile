import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

class SensorView extends StatelessWidget {
  SensorView({super.key});
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
              const Text('Sensor',
                  style: TextStyle(
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
              const Text('Sensor Details',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Color(0xFF616161),
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  )),
              const Spacer(),
              GestureDetector(
                onTap: () {},
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
                "combined sensor: ",
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/location.png',
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Field location",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 34),
                      child: Text(
                        "combined sensor ",
                        style: TextStyle(
                            color: borderColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ]),
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/ha4tag.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Serial number",
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
                          "fire5555-lsksksk",
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
                        const Text(
                          "192.168.1.2",
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/material-symbols-light_wifi (1).png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "255.255.6.8",
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
                          "15/5/2025",
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/material-symbols-light_electric-bolt-outline-rounded.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "15/5/2025",
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/Vector2.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "15/5/2025",
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/calender.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "15/5/2025",
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/lucide_battery.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 90,
                          height: 10,
                          child: LinearProgressIndicator(
                            value: 85 / 100,
                            backgroundColor:
                                const Color.fromARGB(63, 97, 97, 97),
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
                  ]),
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
                        const Text(
                          "person",
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
          ]),
        ),
      )),
    );
  }
}
