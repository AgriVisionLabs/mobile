// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/bloc/control_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:intl/intl.dart';

class ViewTask extends StatelessWidget {
  final String farmName;
  const ViewTask({super.key, required this.farmName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlBloc, ControlState>(
      builder: (context, state) {
        if (state is ViewTaskFailure) {
          return Scaffold(
            body: Center(
              child: Text('Failed to load task'),
            ),
          );
        }
        if (state is ViewTaskSuccess) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
              child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                state.task.title,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  context.read<ControlBloc>().add(
                                      OpenFarmTasksEvent(
                                          farmId: state.task.farmId));
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.grey[600],
                                  size: 24,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Created on ${DateFormat('MMM dd, yyyy').format(state.task.assignedAt!)} by ${state.task.createdBy}",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            width: MediaQuery.sizeOf(context).width,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              state.task.description ?? "No Description",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Manrope",
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Field",
                            style: TextStyle(
                              fontSize: 19,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 12),
                              Image.asset(
                                "assets/images/location.png",
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 5),
                              BlocBuilder<FieldBloc, FieldState>(
                                builder: (context, state) {
                                  if (state is FieldSuccess) {
                                    return Text(
                                        "$farmName - ${state.field.name}",
                                        style: const TextStyle(
                                          color: Color(0xff616161),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "manrope",
                                        ));
                                  }
                                  return const Text("something went wrong",
                                      style: TextStyle(
                                        color: Color(0xff616161),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "manrope",
                                      ));
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Due Date",
                            style: TextStyle(
                              fontSize: 19,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 12),
                              Image.asset(
                                "assets/images/calender.png",
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 5),
                              Text(
                                DateFormat('MMM dd, yyyy')
                                    .format(state.task.assignedAt!),
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontFamily: 'manrope-bold',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Status",
                            style: TextStyle(
                              fontSize: 19,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 12),
                              Container(
                                height: 30,
                                width: 135,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: borderColor,
                                    width: 1.8,
                                  ),
                                ),
                                child: Text(
                                  state.task.completedAt == null
                                      ? "Not Completed"
                                      : "Completed",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Priority",
                            style: TextStyle(
                              fontSize: 19,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(children: [
                            SizedBox(width: 12),
                            Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                color: state.task.itemPriority == 0
                                    ? Colors.green
                                    : state.task.itemPriority == 2
                                        ? Colors.orange
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                state.task.itemPriority == 0
                                    ? "Low"
                                    : state.task.itemPriority == 2
                                        ? "Medium"
                                        : "High",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                          SizedBox(
                            height: 24,
                          ),
                          Divider(
                            color: Colors.grey[400],
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text('Assigned To',
                              style: TextStyle(
                                fontSize: 19,
                                fontFamily: "Manrope",
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Row(children: [
                            SizedBox(width: 12),
                            Image.asset(
                              'assets/images/person.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.task.assignedTo ?? "Not Assigned",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                state.task.assignedTo == null
                                    ? SizedBox(
                                        height: 1,
                                      )
                                    : Text(
                                        'Manager',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Manrope",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                              ],
                            )
                          ]),
                          SizedBox(
                            height: 24,
                          ),
                          Divider(
                            color: Colors.grey[400],
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Actions',
                            style: TextStyle(
                              fontSize: 19,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 12),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 212,
                                  height: 45,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: SizedBox(
                                    height: 300,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/white_check_mark.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          "Mark complete",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Manrope",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 74,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<ControlBloc>().add(
                                      OpenFarmTasksEvent(
                                          farmId: state.task.farmId));
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 110,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.grey[600]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Manrope",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  context.read<ControlBloc>().add(
                                      OpenFarmTasksEvent(
                                          farmId: state.task.farmId));
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 99,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.grey[600]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Manrope",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        );
      },
    );
  }
}
