import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});
  
  @override
    State<TaskScreen> createState() => _TaskScreen();
  }

class _TaskScreen extends State<TaskScreen> {
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: const Center(
        child: Text('Task Screen'),
      ),
    );
  }
}