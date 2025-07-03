import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/view_task.dart';
import 'package:intl/intl.dart';

class TaskBoard extends StatefulWidget {
  final String farmName;
  final String farmId;
  const TaskBoard({super.key, required this.farmName, required this.farmId});

  @override
  State<TaskBoard> createState() => _TaskBoardState();
}

class _TaskBoardState extends State<TaskBoard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlBloc, ControlState>(
      builder: (context, state) {
        if (state is ViewTasksFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        } else if (state is ViewTasksSuccess) {
          final myTasks =
              state.tasks.where((task) => task.completedAt == null).toList();
          return Container(
            padding: const EdgeInsets.only(bottom: 20),
            height: myTasks.length == 1 ? 250 : 530,
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: myTasks.length,
                    (context, index) {
                      final item = myTasks[index];
                      context.read<FieldBloc>().add(ViewFieldDetails(
                          farmId: item.farmId, fieldId: item.fieldId));
                      return Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        padding: const EdgeInsets.only(top: 24),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: const Color.fromARGB(62, 13, 18, 28),
                                width: 1),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(50, 0, 0, 0),
                                  blurRadius: 15,
                                  spreadRadius: 0.7,
                                  offset: Offset(0, 2.25))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(item.title,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "manrope",
                                          )),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: item.itemPriority == 0
                                                ? Colors.green
                                                : item.itemPriority == 2
                                                    ? Colors.orange
                                                    : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: borderColor, width: 1)),
                                        child: Center(
                                          child: Text(
                                            item.itemPriority == 0
                                                ? "Low"
                                                : item.itemPriority == 2
                                                    ? "Medium"
                                                    : "High",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/location.png',
                                      ),
                                      const SizedBox(width: 8),
                                      BlocBuilder<FieldBloc, FieldState>(
                                        builder: (context, state) {
                                          if (state is FieldSuccess) {
                                            return Text(
                                                "${widget.farmName} - ${state.field.name}",
                                                style: const TextStyle(
                                                  color: Color(0xff616161),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "manrope",
                                                ));
                                          }
                                          return const Text(
                                              "something went wrong",
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
                                  const SizedBox(height: 16),
                                  Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 100,
                                      maxHeight: 100,
                                    ),
                                    child: Scrollbar(
                                      thumbVisibility: false,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              item.description ??
                                                  "No Description",
                                              style: const TextStyle(
                                                color: Color(0xff0D121C),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "manrope",
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/calender.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        DateFormat('MMM dd, yyyy')
                                            .format(item.assignedAt!),
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontFamily: 'manrope-bold',
                                        ),
                                      ),
                                      const Spacer(),
                                      Image.asset(
                                        'assets/images/person_icon.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        item.assignedTo ?? 'Not Assigned',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontFamily: 'manrope-bold',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color.fromARGB(63, 13, 18, 28),
                              thickness: 1,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<ControlBloc>().add(
                                          DeteteTaskEvent(
                                              farmId: item.farmId,
                                              taskId: item.id));
                                      context.read<ControlBloc>().add(
                                          OpenFarmTasksEvent(
                                              farmId: item.farmId));
                                    },
                                    child: Image.asset(
                                      'assets/images/delete.png',
                                      width: 30,
                                      height: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<ControlBloc>().add(
                                          OpenTaskEvent(
                                              farmId: item.farmId,
                                              taskId: item.id));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewTask(
                                                farmName: widget.farmName)),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/eye.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 200),
                                  item.assignedTo == null
                                      ? GestureDetector(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.add,
                                            color: primaryColor,
                                          ))
                                      : const SizedBox(
                                          width: 30,
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        context.read<ControlBloc>().add(
                                            CompleteTaskEvent(
                                                farmId: item.farmId,
                                                taskId: item.id));
                                        context.read<ControlBloc>().add(
                                            OpenFarmTasksEvent(
                                                farmId: item.farmId));
                                      },
                                      child: Image.asset(
                                        'assets/images/circle_check.png',
                                        width: 34,
                                        height: 34,
                                      )),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is TasksEmpty) {
          return const SizedBox(
              child: Center(
                  child: Text('No Tasks units found',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontFamily: "manrope",
                        color: primaryColor,
                      ))));
        }
        return const SizedBox(
            child: Center(
                child: CircularProgressIndicator(
          color: primaryColor,
        )));
      },
    );
  }
}
