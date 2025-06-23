import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/farm_model.dart';

class SensorAndDevices extends StatefulWidget {
  const SensorAndDevices({super.key});

  @override
  State<SensorAndDevices> createState() => _SensorAndDevicesState();
}

class _SensorAndDevicesState extends State<SensorAndDevices> {
  String? selectedFarmId;
  String? selectedFarmName;
  bool active = true;
  bool isSwitched = false;
  List<FarmModel>? farms;
  bool isSensorSelected = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FarmBloc, FarmState>(
      listener: (context, state) {
        if (state is FarmEmpty) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('There is no farms to show'),
              ),
            );
          });
        } else if (state is FarmsLoaded) {
          farms = state.farms;
        } else if (state is FarmFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 150, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sensors & Devices",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "manrope",
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
                  width: 289,
                  height: 53,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: borderColor, width: 1)),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    value: selectedFarmId,
                    isExpanded: true,
                    icon: Image.asset(
                      'assets/images/arrow.png',
                    ),
                    onChanged: (farms == null || farms!.isEmpty)
                        ? null
                        : (newValue) {
                            final selectedFarm = farms!
                                .where((farm) => farm.farmId == newValue)
                                .toList();
                            if (selectedFarm.isNotEmpty) {
                              setState(() {
                                selectedFarmId = newValue;
                                selectedFarmName = selectedFarm.first.name;
                              });
                            }
                          },
                    items: farms?.map<DropdownMenuItem<String>>((farm) {
                      return DropdownMenuItem<String>(
                        value: farm.farmId,
                        child: Text(farm.name!),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  width: 282,
                  height: 62,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(43, 159, 159, 159),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Sensor Button
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 105,
                        decoration: BoxDecoration(
                          color: isSensorSelected
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSensorSelected = true;
                            });
                          },
                          child: Text(
                            "Sensors",
                            style: TextStyle(
                              color:
                                  isSensorSelected ? primaryColor : borderColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: "manrope",
                            ),
                          ),
                        ),
                      ),
                      // Irrigation Units Button
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 157,
                        decoration: BoxDecoration(
                          color:!isSensorSelected
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSensorSelected = false;
                            });
                          },
                          child: Text(
                            "Irrigation Units",
                            style: TextStyle(
                              color:
                                  !isSensorSelected ? primaryColor : borderColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: "manrope",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
