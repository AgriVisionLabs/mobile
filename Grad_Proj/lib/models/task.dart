import 'package:uuid/uuid.dart';

class Task {
  final String id;
  String description;
  String dueDate;
  bool isCompleted;

  Task({
    required this.id,
    required this.description,
    required this.dueDate,
    required this.isCompleted
  });

  factory Task.create({
    required String ? id,
    required String ? description,
    required String ? dueDate,
  })=>Task(
    //is used to uniquely identify an object or a record in a database
    id: const Uuid().v1(), 
    description: description ?? "", 
    dueDate: dueDate ?? "", 
    isCompleted: false);
}