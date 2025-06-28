import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

class ScheduleMaintenance extends StatefulWidget {
  const ScheduleMaintenance({super.key});

  @override
  State<ScheduleMaintenance> createState() => _ScheduleMaintenanceState();
}

class _ScheduleMaintenanceState extends State<ScheduleMaintenance> {
  bool isSchedule = true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.all(24),
        child: SingleChildScrollView(
            child: Column(
          children: [
            //Schedule Maintenance for Sensor Unit A1
            const Text("Schedule Maintenance For Sensor Unit A1",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: "manrope",
                )),
            const SizedBox(height: 10),
            const Text("Schedule upcoming maintenance for this device.",
                style: TextStyle(
                  color: grayColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "manrope",
                )),
                const SizedBox(height: 24),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 180,
                  height: 54,
                  decoration: BoxDecoration(
                    color: isSchedule ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF616161),
                      width: 1,
                    ),
                  ),
                  child:  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/calender.png',
                          width: 24,
                          height: 24,
                          color: isSchedule ?  Colors.white : primaryColor ,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "schedule",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.bold,
                            color: isSchedule ?  Colors.white : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 180,
                  height: 54,
                  decoration: BoxDecoration(
                    color: !isSchedule ? primaryColor :Colors.white,
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
                          'assets/images/mark.png',
                          width: 24,
                          height: 24,
                          color: !isSchedule ? Colors.white : primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Log Completed",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.bold,
                            color: !isSchedule ? Colors.white : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 24),
          ],
        )),
      )),
    );
  }
}
