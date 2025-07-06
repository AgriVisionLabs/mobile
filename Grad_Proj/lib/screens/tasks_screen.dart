// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/farm_model.dart';
import 'package:grd_proj/screens/completed_task.dart';
import 'package:grd_proj/screens/my_tasks.dart';
import 'package:grd_proj/screens/new_task.dart';
import 'package:grd_proj/screens/task_board.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreen();
}

class _TaskScreen extends State<TaskScreen> {
  late TextEditingController controller;
  String? selectedValue;
  String? selectedFarmId;
  int? selectedFarmFieldNo;
  String? selectedFarmName;
  int selectedTab = 0;
  List<FarmModel>? farms;
  final List<String> tabs = ["All Tasks", "My Tasks", "Completed Tasks"];
  @override
  Widget build(BuildContext context) {
    context.read<FarmBloc>().add(OpenFarmEvent());
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
          selectedFarmId = farms![0].farmId;
          selectedFarmName = farms![0].name;
          context
              .read<ControlBloc>()
              .add(OpenFarmTasksEvent(farmId: selectedFarmId!));
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
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 18),
                          Row(
                            children: [
                              Text(
                                'Tasks',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontFamily: 'manrope-medium',
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
                                    if (selectedFarmId == null) {
                                      print(
                                          "===================Forbidden=======================");
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Please choose farm first"),
                                          ),
                                        );
                                      });
                                    } else if (selectedFarmFieldNo != 0) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NewTask(
                                                    farmId: selectedFarmId!,
                                                  )));
                                    } else {
                                      print(
                                          "===================Forbidden=======================");
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("No Fields Exist"),
                                          ),
                                        );
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          SizedBox(
                            width: 280,
                            height: 60,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Farm',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w600),
                                ),
                                value: selectedFarmId,
                                items: farms?.map((farm) {
                                  return DropdownMenuItem<String>(
                                    value: farm.farmId,
                                    child: Text(
                                      farm.name,
                                      style: const TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (farms == null || farms!.isEmpty)
                                    ? null
                                    : (value) {
                                        setState(() {
                                          final selectedFarm = farms!
                                              .where((farm) =>
                                                  farm.farmId == value)
                                              .toList();
                                          selectedFarmId = value;
                                          selectedFarmName =
                                              selectedFarm.first.name;
                                          selectedFarmFieldNo =
                                              selectedFarm.first.fieldsNo;
                                          context.read<ControlBloc>().add(
                                              OpenFarmTasksEvent(
                                                  farmId: selectedFarmId!));
                                        });
                                      },
                                buttonStyleData: ButtonStyleData(
                                  height: 55,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: borderColor, width: 1),
                                    color: Colors.white,
                                  ),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    border: Border.all(color: borderColor),
                                  ),
                                  elevation: 2,
                                  offset: const Offset(0, -5),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  iconSize: 30,
                                  iconEnabledColor: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            height: 62,
                            width: 410,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0x4dD9D9D9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: List.generate(3, (index) {
                                final isSelected = selectedTab == index;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTab = index;
                                      });
                                    },
                                    child: Container(
                                      height: 46,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                            : const Color.fromARGB(0, 0, 0, 0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        tabs[index],
                                        style: TextStyle(
                                            color: isSelected
                                                ? primaryColor
                                                : Colors.grey,
                                            fontSize: 15,
                                            fontFamily: "manrope",
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(height: 20),
                          if (selectedTab == 0) ...[
                            // SizedBox(height: 16),
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
                                    : TaskBoard(
                                        farmName: selectedFarmName!,
                                        farmId: selectedFarmId!)),
                          ],
                          if (selectedTab == 1) ...[
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
                                    : MyTasks(
                                        farmName: selectedFarmName!,
                                        farmId: selectedFarmId!)),
                          ],
                          if (selectedTab == 2) ...[
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
                                    : CompletedTask(
                                        farmName: selectedFarmName!,
                                        farmId: selectedFarmId!)),
                          ],
                        ],
                      ),
                    ],
                  ))),
        );
      },
    );
  }
}
