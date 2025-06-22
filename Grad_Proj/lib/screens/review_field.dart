// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/cache/cache_helper.dart';

import '../Components/color.dart';

class ReviewField extends StatefulWidget {
  final String name;
  final int size;
  final int crop;
  const ReviewField(
      {super.key, required this.name, required this.size, required this.crop});

  @override
  State<ReviewField> createState() => _ReviewFieldState();
}

class _ReviewFieldState extends State<ReviewField> {
  List field = [];
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    String crop = widget.crop == 1
        ? "corn"
        : widget.crop == 2
            ? "Wheal"
            : widget.crop == 3
                ? "Rice"
                : "Tomato";
    return BlocBuilder<FieldBloc, FieldState>(
      builder: (context, state) {
        return SizedBox(
          width: 380,
          height: 680,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                const Text('Field Details',
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
            SizedBox(
              width: 340,
              height: 59,
              child: Row(children: [
                Column(children: [
                  const Text('Field Name',
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  Text(widget.name,
                      style: const TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400))
                ]),
                const Spacer(),
                Column(children: [
                  const Text('Field Size',
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  Text('${widget.size} acres',
                      style: const TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400))
                ]),
              ]),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(children: [
                const Text('Crop Type',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                Text(crop,
                    style: const TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400))
              ]),
            ),
            const SizedBox(
              height: 24,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  width: 200,
                  height: 55,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor,
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<FieldBloc>().add(OpenFieldEvent(
                          farmname: CacheHelper.getData(key: 'farmname'),
                          farmId: CacheHelper.getData(key: 'farmId'),
                          roleName: CacheHelper.getData(key: 'roleName'),
                          size: CacheHelper.getData(key: 'area'),
                          location: CacheHelper.getData(key: 'location'),
                          soiltype: CacheHelper.getData(key: 'soiltype')
                        ));
                      },
                      child: Text(
                        'Create Feild',
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

  // Widget _buildRolesList() {
  //   return SizedBox(
  //     width: 380,
  //     height: 260,
  //     child: ListView.builder(
  //         itemCount: 2,
  //         scrollDirection: Axis.vertical,
  //         itemBuilder: (context, index) {
  //           return SizedBox(
  //               width: 380,
  //               height: 140,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(index == 1 ? 'Irrigation Units' : 'Sensor Units',
  //                       style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.w400,
  //                       )),
  //                   Container(
  //                     height: 76,
  //                     margin: const EdgeInsets.symmetric(vertical: 12),
  //                     decoration: BoxDecoration(
  //                       color: const Color.fromRGBO(30, 105, 48, 0.15),
  //                       borderRadius: BorderRadius.circular(15),
  //                     ),
  //                     child: ListTile(
  //                       title: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           //Task Descrption
  //                           Text(
  //                             field[index + 1][0],
  //                             style: const TextStyle(
  //                               fontFamily: 'Manrope',
  //                               color: Colors.black,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w400,
  //                               // decoration: TextDecoration.lineThrough
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 7,
  //                           ),

  //                           Text(field[index + 1][(1)],
  //                               style: const TextStyle(
  //                                 fontFamily: 'Manrope',
  //                                 color: borderColor,
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.w400,
  //                                 // decoration: TextDecoration.lineThrough
  //                               ))
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ));
  //         }),
  //   );
  // }
}
