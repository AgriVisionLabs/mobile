// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';

import '../Components/color.dart';

class Review extends StatefulWidget {
  final String name;
  final int size;
  final String location;
  final int soil;
  final String roles;
  final bool editFarm;
  const Review(
      {super.key,
      this.editFarm = false,
      required this.name,
      required this.size,
      required this.location,
      required this.roles,
      required this.soil});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  List editFarm = [
    'Green Farm',
    '900',
    'Ismailia',
    'Clay',
    'Hessian',
    'Manager'
  ];
  List<Map<String, dynamic>>? invites;
  @override
  Widget build(BuildContext context) {
    String soil = widget.soil == 1
        ? "Sandy"
        : widget.soil == 2
            ? "Clay"
            : "Loamy";
    List<dynamic> decoded = jsonDecode(widget.roles);
    invites = List<Map<String, dynamic>>.from(decoded);
    return BlocBuilder<FarmBloc, FarmState>(
      builder: (context, state) {
        return SizedBox(
          width: 380,
          height: 680,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                width: 380,
                height: 59,
                child: Row(children: [
                  Column(children: [
                    const Text('Farm Name',
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    Text(widget.editFarm ? editFarm[0] : widget.name,
                        style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400))
                  ]),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(children: [
                    const Text('Farm Size',
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    Text(
                        widget.editFarm
                            ? "${editFarm[1]} acres"
                            : '${widget.size} acres',
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
                    Text(widget.editFarm ? editFarm[2] : widget.location,
                        style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400))
                  ]),
                  const Spacer(),
                  Column(children: [
                    Text('Soil Type',
                        style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    Text(widget.editFarm ? editFarm[3] : '$soil Soil',
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
            widget.editFarm
                ? SizedBox(
                    height: 1,
                  )
                : Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        width: 200,
                        height: 55,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryColor,
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<FarmBloc>().add(OpenFarmEvent());
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
      },
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
                itemCount: widget.editFarm ? 1 : invites?.length,
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
                            widget.editFarm
                                ? editFarm[4]
                                : invites?[index]['receiverUserName'],
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              // decoration: TextDecoration.lineThrough
                            ),
                          ),
                          const Spacer(),

                          Text(
                              widget.editFarm
                                  ? editFarm[5]
                                  : invites?[index]['roleName'],
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                // decoration: TextDecoration.lineThrough
                              )),

                          widget.editFarm
                              ? Align(
                                  heightFactor: 1,
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width: 20,
                                    height: 30,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 18,
                                        )),
                                  ),
                                )
                              : SizedBox(
                                  width: 1,
                                )
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
