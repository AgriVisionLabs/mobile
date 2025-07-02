import 'package:flutter/material.dart';

class FieldView extends StatefulWidget {
  const FieldView({super.key});

  @override
  State<FieldView> createState() => _FieldViewState();
}

class _FieldViewState extends State<FieldView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Container(
        margin: EdgeInsets.fromLTRB(16, 100, 16, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              
            )
          ],
        ),
      )),
    );
  }
}