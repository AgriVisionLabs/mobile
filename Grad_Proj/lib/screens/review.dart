// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../Components/color.dart';

class Review extends StatefulWidget {
  final List farm;
  const Review({super.key, required this.farm});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  List farm =[];
  @override
  Widget build(BuildContext context) {
    farm = widget.farm;
    return SizedBox(
      width: 380,
      height: 630,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            const Text('Farm Details',
                style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Center(
          child: SizedBox(
            width: 332,
            height: 59,
            child: Row(children: [
              Column(children: [
                const Text('Farm Name',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                Text(farm[0][0],
                    style: const TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400))
              ]),
              const Spacer(),
              Column(children: [
                const Text('Farm Size',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                Text('${farm[0][1]} acres',
                    style: const TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400))
              ]),
            ]),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Center(
          child: SizedBox(
            width: 332,
            height: 59,
            child: Row(children: [
              Column(children: [
                const Text('Location',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                Text(farm[0][2],
                    style: const TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400))
              ]),
              const Spacer(),
              Column(children: [
                const Text('Soil Type',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                Text(farm[0][3]+' Soil',
                    style: const TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400))
              ]),
            ]),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        _buildRolesList(),
        const Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
              width: 200,
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: primaryColor,
              ),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Create Farm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ))),
        )
      ]),
    );
  }


Widget _buildRolesList() {
  return SizedBox(
    width: 380,
    height: 260,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Team Members',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            )),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 380,
          height: 220,
          child: ListView.builder(
              itemCount: farm.length-1,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(30, 105, 48, 0.15),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        //Task Descrption
                        Text(
                          farm[index+1][0],
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            // decoration: TextDecoration.lineThrough
                          ),
                        ),
                        const Spacer(),

                        //Due Date
                        
                        Text(farm[index+1][(1)],
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              // decoration: TextDecoration.lineThrough
                            ))
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    ),
  );
}
}
