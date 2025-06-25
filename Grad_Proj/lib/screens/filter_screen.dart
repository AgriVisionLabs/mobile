import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/fields_screen.dart';

class FilterScreen extends StatefulWidget {
  final String farmId;
  const FilterScreen({super.key, required this.farmId});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedFieldId;
  String? selectedtype;
  String? selectedstatus;
  // ignore: non_constant_identifier_names
  List<String> rules_types = [
    "Threshold",
    "Schedualed",
  ];
  // ignore: non_constant_identifier_names
  List<String> rules_status = ["inactive", "active"];
  @override
  Widget build(BuildContext context) {
    context.read<FieldBloc>().add(OpenFieldEvent(farmId: widget.farmId));
    return BlocBuilder<FieldBloc, FieldState>(
      builder: (context, state) {
        if (state is FieldFailure) {
          return Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: const EdgeInsets.all(31),
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.close, color: Colors.black),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Filter Irrigation Units And Automation Rules",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "manrope",
                                  color: primaryColor,
                                )),
                            SizedBox(
                              height: 100,
                            ),
                            Center(
                              child: Text("Something Went Wrong",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "manrope",
                                    color: primaryColor,
                                  )),
                            )
                          ],
                        ),
                      ])));
        }
        if (state is FieldLoaded) {
          return Material(
              type: MaterialType.transparency,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.all(31),
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.black),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Filter Irrigation Units And Automation Rules",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                fontFamily: "manrope",
                                color: primaryColor,
                              )),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text("Filter by Field",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                            color: Colors.black,
                          )),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 20),
                        width: 320,
                        height: 53,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: borderColor, width: 2.5)),
                        child: DropdownButton<String>(
                          hint: const Text("All Fields",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: "manrope",
                              )),
                          dropdownColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          value: selectedFieldId,
                          isExpanded: true,
                          icon: Image.asset(
                            'assets/images/arrow.png',
                            color: borderColor,
                          ),
                          onChanged: (fields == null || fields!.isEmpty)
                              ? null
                              : (newValue) {
                                  setState(() {
                                    selectedFieldId = newValue;
                                  });
                                },
                          items: state.fields
                              .map<DropdownMenuItem<String>>((field) {
                            return DropdownMenuItem<String>(
                              value: field.id,
                              child: Text(field.name),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text("Filter by Rule Type",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                            color: Colors.black,
                          )),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 20),
                        width: 320,
                        height: 53,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: borderColor, width: 2.5)),
                        child: DropdownButton<String>(
                          hint: const Text("All Types",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: "manrope",
                              )),
                          dropdownColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          value: selectedtype,
                          isExpanded: true,
                          icon: Image.asset(
                            'assets/images/arrow.png',
                            color: borderColor,
                          ),
                          onChanged: (fields == null || fields!.isEmpty)
                              ? null
                              : (newValue) {
                                  setState(() {
                                    selectedtype = newValue;
                                  });
                                },
                          items: rules_types.map((type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text("Filter by Rule status",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                            color: Colors.black,
                          )),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        width: 320,
                        height: 53,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: borderColor, width: 2.5)),
                        child: DropdownButton<String>(
                          hint: const Text("All Statuses",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: "manrope",
                              )),
                          dropdownColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          value: selectedstatus,
                          isExpanded: true,
                          icon: Image.asset(
                            'assets/images/arrow.png',
                            color: borderColor,
                          ),
                          onChanged: (fields == null || fields!.isEmpty)
                              ? null
                              : (newValue) {
                                  setState(() {
                                    selectedstatus = newValue;
                                  });
                                },
                          items: rules_status.map((status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: 114,
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color:
                                          const Color.fromARGB(168, 51, 51, 51),
                                      width: 2),
                                  color: Colors.white,
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      context.read<FieldBloc>().add(
                                          OpenFarmIrrigationUnitsEvent(
                                              farmId: widget.farmId));
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancle",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "manrope",
                                          color: Colors.black,
                                        )))),
                            const SizedBox(width: 60),
                            Container(
                                width: 150,
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: primaryColor,
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      if (selectedFieldId == null &&
                                          selectedstatus == null &&
                                          selectedtype == null) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text("ِAlert",
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "manrope",
                                                  color: primaryColor,
                                                )),
                                            backgroundColor: Colors.white,
                                            content: const Text(
                                                "You need to choose at least one fitering type",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "manrope",
                                                  color: Colors.black,
                                                )),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Cancle",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: "manrope",
                                                      color: Colors.black,
                                                    )),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  // تنفيذ الإجراء
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Ok",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: "manrope",
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (selectedFieldId == null ||
                                          selectedFieldId!.isEmpty) {
                                        context.read<FieldBloc>().add(
                                            OpenFarmIrrigationUnitsEvent(
                                                farmId: widget.farmId));
                                        if(selectedstatus == null || selectedstatus!.isEmpty) {
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        context.read<FieldBloc>().add(
                                            OpenFieldIrrigationUnitsEvent(
                                                farmId: widget.farmId,
                                                fieldId: selectedFieldId!));
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text("Apply Filter",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "manrope",
                                          color: Colors.white,
                                        ))))
                          ])
                    ],
                  ),
                ),
              ));
        } else if (state is FieldEmpty) {
          return Material(
              type: MaterialType.transparency,
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: const EdgeInsets.all(31),
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 15,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.black),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                            const Center(
                              child:
                                  Text("Sorry This Farm Has No Entered Fields",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "manrope",
                                        color: Colors.black,
                                      )),
                            ),
                          ]))));
        } else {
          return Material(
            type: MaterialType.transparency,
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    margin: const EdgeInsets.all(31),
                    height: MediaQuery.of(context).size.height * 0.7,
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ))),
          );
        }
      },
    );
  }
}
