import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  
  @override
    State<ScanScreen> createState() => _ScanScreen();
  }

class _ScanScreen extends State<ScanScreen> {
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: const Center(
        child: Text('Scan Screen'),
      ),
    );
  }
}