import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

class SensorView extends StatelessWidget {
  const SensorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  color:  Color(0xFF616161),
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
          ])
        ]),
      )),
    );
  }
}
