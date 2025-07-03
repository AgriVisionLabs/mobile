import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/task.dart';

class Activitybar extends StatefulWidget {
  const Activitybar({super.key});

  @override
  State<Activitybar> createState() => _ActivitybarState();
}

class _ActivitybarState extends State<Activitybar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'manrope',
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Tasks().tasks.isNotEmpty
              ? ListView.builder(
                  itemCount: Tasks().tasks.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.horizontal,
                      onDismissed: (_) {
                        /// Remove the current task
                      },
                      key: Key(index.toString()),
                      background: const Icon(
                        Icons.delete,
                        color: borderColor,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),

                        // Each activity tile
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),

                          /// Person Image (Leading)
                          leading: Image.asset(
                            'assets/images/person.png',
                            width: 36,
                            height: 36,
                          ),

                          /// Task content in **vertical layout**
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Tasks().tasks[index].description,
                                style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4), // Small spacing

                              /// Due Date now appears **below** description
                              Text(
                                Tasks().tasks[index].dueDate,
                                style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : const SizedBox(
                  child: Center(
                    child: Text(
                      "No Activity For Now",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

/// Mock Data for Tasks
class Tasks {
  List<Task> tasks = [
    Task(
      id: "1",
      description: "Updated Irrigation Schedule For Sector A",
      dueDate: "6 mins ago",
      isCompleted: false,
    ),
    Task(
      id: "2",
      description: "Updated Irrigation Schedule For Sector A",
      dueDate: "2 hours ago",
      isCompleted: false,
    ),
    Task(
      id: "3",
      description: "Updated Irrigation Schedule For Sector A",
      dueDate: "10:30 AM",
      isCompleted: false,
    ),
    Task(
      id: "4",
      description: "Order new seeds for next season",
      dueDate: "Yesterday",
      isCompleted: false,
    ),
  ];
}
