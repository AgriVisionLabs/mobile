// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/models/farm_model.dart';
import 'package:grd_proj/screens/add_auomation_rules.dart';
import 'package:grd_proj/screens/add_irrigation_unit.dart';
import 'package:grd_proj/screens/automation_rules.dart';
import 'package:grd_proj/screens/filter_screen.dart';
import 'package:grd_proj/screens/irrigation_devices.dart';
import '../Components/color.dart';

class IrrigationConrtol extends StatefulWidget {
  const IrrigationConrtol({super.key});

  @override
  State<IrrigationConrtol> createState() => _IrrigationConrtolState();
}

class _IrrigationConrtolState extends State<IrrigationConrtol> {
  String? selectedFarmId;
  String? selectedFieldId;
  String? selectedstatus;
  String? selectedtype;
  String? selectedFarmName;
  int? selectedFarmFieldNo;
  List<FarmModel>? farms;

  void _onInputChanged(
      String selectedFieldId, String selectedstatus, String selectedtype) {
    setState(() {
      this.selectedFieldId = selectedFieldId;
      this.selectedstatus = selectedstatus;
      this.selectedtype = selectedtype;

      irrigationKey.currentState?.reloadData();
      automatedKey.currentState?.reloadData();
    });
  }

  @override
  void initState() {
    context.read<FarmBloc>().add(OpenFarmEvent());
    super.initState();
  }

  final GlobalKey<IrrigationDevicesState> irrigationKey = GlobalKey();
  final GlobalKey<IrrigationDevicesState> automatedKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FarmBloc, FarmState>(
      listener: (context, state) {
        if (state is FarmEmpty) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
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
            margin: const EdgeInsets.only(top: 22, left: 16, right: 16),
            height: MediaQuery.sizeOf(context).height,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Irrigation Control",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "manrope",
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (selectedFarmId == null) {
                              // ignore: avoid_print
                              print(
                                  "===================Forbidden=======================");
                              ScaffoldMessenger.of(context).clearSnackBars();
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please choose farm first"),
                                  ),
                                );
                              });
                            } else if (selectedFarmFieldNo == 0) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please create fields first"),
                                  ),
                                );
                              });
                            } else {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierColor:
                                      const Color.fromARGB(5, 0, 0, 0),
                                  builder: (BuildContext context) {
                                    return FilterScreen(
                                      onInputChanged: _onInputChanged,
                                      farmId: selectedFarmId!,
                                    );
                                  });
                            }
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF333333),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Image.asset(
                                  'assets/images/filter.png',
                                  width: 24,
                                  height: 24,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Filter',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "manrope",
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
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
                            style: TextStyle(
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
                                        .where(
                                            (farm) => farm.farmId == newValue)
                                        .toList();
                                    if (selectedFarm.isNotEmpty) {
                                      setState(() {
                                        selectedFarmId = newValue;
                                        selectedFarmName =
                                            selectedFarm.first.name;
                                        context
                                            .read<FieldBloc>()
                                            .add(OpenFarmIrrigationUnitsEvent(
                                              farmId: selectedFarmId!,
                                            ));
                                        context
                                            .read<ControlBloc>()
                                            .add(OpenFarmAutomationRulesEvent(
                                              farmId: selectedFarmId!,
                                            ));
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
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          'Irrigation Units',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "manrope",
                            color: Color(0xFF333333),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              if (selectedFarmId != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddIrrigationUnit(
                                          farmId: selectedFarmId!)),
                                );
                              } else {
                                // ignore: avoid_print
                                print(
                                    "===================Forbidden=======================");
                                ScaffoldMessenger.of(context).clearSnackBars();
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please choose farm first"),
                                    ),
                                  );
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                        child: selectedFarmId == null
                            ? Center(
                                child: Text('Please Choose Farm',
                                    style: TextStyle(
                                      color: Color(0xff1E6930),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "manrope",
                                    )),
                              )
                            : IrrigationDevices(
                                key: irrigationKey,
                                farmName: selectedFarmName!,
                                farmId: selectedFarmId!,
                                fieldId: selectedFieldId,
                                statue: selectedstatus,
                              )),
                    SizedBox(height: 44),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          'Automation Rules',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "manrope",
                            color: Color(0xFF333333),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              // Add your onPressed code here!
                              if (selectedFarmId == null) {
                                // ignore: avoid_print
                                print(
                                    "===================Forbidden=======================");
                                ScaffoldMessenger.of(context).clearSnackBars();
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please choose farm first"),
                                    ),
                                  );
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddAuomationRules(
                                          farmId: selectedFarmId!)),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                        child: selectedFarmId == null
                            ? Center(
                                child: Text('Please Choose Farm',
                                    style: TextStyle(
                                      color: Color(0xff1E6930),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "manrope",
                                    )),
                              )
                            : AutomationRules(
                                key: automatedKey,
                                farmName: selectedFarmName!,
                                farmId: selectedFarmId!,
                                fieldId: selectedFieldId,
                                type: selectedtype,
                                statue: selectedstatus,
                              )),
                    SizedBox(height: 50),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
