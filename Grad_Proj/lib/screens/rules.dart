import 'package:flutter/material.dart';

class Rules extends StatefulWidget {
  final Function(int) onInputChanged;
  final int currentIndex;
  final String fieldId;
  final String farmId;
  final bool form;
  const Rules(
      {super.key,
      required this.onInputChanged,
      required this.currentIndex,
      required this.farmId,
      required this.fieldId,
      required this.form});

  @override
  State<Rules> createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}