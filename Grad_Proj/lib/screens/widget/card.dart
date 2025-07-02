import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final double height;
  final Widget child;

  const CardContainer({required this.height, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(50, 0, 0, 0),
                blurRadius: 10,
                spreadRadius: 0.7,
                offset: Offset(0, 2.25))
          ]),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 380,
        height: height,
        child: child,
      ),
    );
  }
}
