import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/task.dart';

class TodoBar extends StatefulWidget {
  const TodoBar({super.key});

  @override
  State<TodoBar> createState() => _TodoBarState();
}



class _TodoBarState extends State<TodoBar> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'To-Do List',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        SizedBox(
            width: double.infinity,
            height: 300,
            child: Tasks().tasks.isNotEmpty
                ?
                //task list is not empty
                ListView.builder(
                    itemCount:Tasks().tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      //container of each task
                      return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            ///remove the current task
                          },
                          //give a unique key to eack task
                          key: Key(index.toString()),
                          background: const Icon(
                            Icons.delete,
                            color: borderColor,
                          ),
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              decoration:
                                  const BoxDecoration(color: Color(0xFFFFFFFF)),

                              //listTile used for constant layout of each item
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(0),

                                //check Icon
                                leading: GestureDetector(
                                  onTap: () {
                                    //check and uncheck the task
                                    setState(() {
                                      isChecked = !isChecked;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(microseconds: 600),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: isChecked ? const Icon(
                                      Icons.check,
                                      color: primaryColor,
                                    ):
                                    const Icon(Icons.check_box_outline_blank
                                    , color: Colors.white),
                                  ),
                                ),

                                //task content
                                title: Row(
                                  children: [
                                    //Task Descrption
                                    SizedBox(
                                      width: 185,
                                      child: Text(
                                        Tasks().tasks[index].description,
                                        style: const TextStyle(
                                          fontFamily: 'Manrope',
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          // decoration: TextDecoration.lineThrough
                                        ),
                                      ),
                                    ),
                                    const Spacer(),

                                    //Due Date
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: Text(
                                          Tasks().tasks[index].dueDate,
                                          style: const TextStyle(
                                            fontFamily: 'Manrope',
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            // decoration: TextDecoration.lineThrough
                                          )),
                                    )
                                  ],
                                ),
                              )));
                    })
                :

                //all tasks are done
                const SizedBox(
                    child: Center(
                    child: Text(
                      "You have done all tasks",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ))),
      ],
    );
  }
}


class Tasks {
  List <Task> tasks = [
  Task(
    id: "1",
    description: "Schedule equipment maintenance",
    dueDate: "Today",
    isCompleted: false
  ),
  Task(
    id: "1",
    description: "Review crop rotation plan",
    dueDate: "Tomorrow",
    isCompleted: false
  ),
  Task(
    id: "1",
    description: "Prepare monthly yield report",
    dueDate: "3 Days",
    isCompleted: false
  ),
  Task(
    id: "1",
    description: "Order new seeds for next season",
    dueDate: "1 Weeks",
    isCompleted: false
  ),
  ];
}


