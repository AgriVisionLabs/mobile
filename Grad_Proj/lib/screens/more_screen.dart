import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});
  
  @override
    State<MoreScreen> createState() => _MoreScreen();
  }

class _MoreScreen extends State<MoreScreen> {
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: const Center(
        child: Text('More Screen'),
      ),
    );
  }
}