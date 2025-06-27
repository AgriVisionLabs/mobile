// import 'package:flutter/material.dart';
// import 'package:grd_proj/components/color.dart';

// class FieldDiseaseDetection extends StatefulWidget {
//   const FieldDiseaseDetection({super.key});

//   @override
//   State<FieldDiseaseDetection> createState() => _FieldDiseaseDetectionState();
// }

// class _FieldDiseaseDetectionState extends State<FieldDiseaseDetection> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//             height: 520,
//             child: CustomScrollView(
//               shrinkWrap: true,
//               slivers: [
//                 SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     childCount: state.devices.length,
//                     (context, index) {
//                       final item = state.devices[index];
//                       return Container(
//                         margin: const EdgeInsets.only(bottom: 20),
//                         padding: const EdgeInsets.only(top: 24),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(25),
//                             border: Border.all(
//                                 color: const Color.fromARGB(62, 13, 18, 28),
//                                 width: 1),
//                             boxShadow: const [
//                               BoxShadow(
//                                   color: Color.fromARGB(50, 0, 0, 0),
//                                   blurRadius: 15,
//                                   spreadRadius: 0.7,
//                                   offset: Offset(0, 2.25))
//                             ]),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 24),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(widget.farmName,
//                                           style: const TextStyle(
//                                             color: Color(0xff1E6930),
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                             fontFamily: "manrope",
//                                           )),
//                                       const Spacer(),
//                                       Container(
//                                         width: 77,
//                                         height: 30,
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(25),
//                                             border: Border.all(
//                                                 color: borderColor, width: 1)),
//                                         child: Center(
//                                           child: Text(
//                                             item.status == 2
//                                                 ? "Active"
//                                                 : "Inactive",
//                                             style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 16),
//                                   Row(
//                                     children: [
//                                       Image.asset(
//                                         'assets/images/location.png',
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(item.fieldName,
//                                           style: const TextStyle(
//                                             color: Color(0xff616161),
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w500,
//                                             fontFamily: "manrope",
//                                           )),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 16),
//                                   Row(
//                                     children: [
//                                       Image.asset(
//                                         'assets/images/ha4tag.png',
//                                         width: 24,
//                                         height: 24,
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(item.name,
//                                           style: const TextStyle(
//                                             color: Color(0xff0D121C),
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w500,
//                                             fontFamily: "manrope",
//                                           )),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//                             Divider(
//                               color: const Color(0xff0D121C).withOpacity(0.25),
//                               thickness: 1,
//                             ),
//                             const SizedBox(height: 10),
//                             Container(
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 24),
//                               child: Row(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       print("edit it");
//                                     },
//                                     child: Image.asset('assets/images/edit.png',
//                                         width: 30, height: 30),
//                                   ),
//                                   const SizedBox(width: 20),
//                                   GestureDetector(
//                                     onTap: () {
//                                          ///Delete
//                                     },
//                                     child: Image.asset(
//                                         'assets/images/delete.png',
//                                         width: 30,
//                                         height: 30),
//                                   ),
//                                   const Spacer(),
//                                   Switch(
//                                     value: item.status == 2,
//                                     onChanged: (value) {
                                     
//                                     },
//                                     activeColor: Colors.white,
//                                     activeTrackColor: primaryColor,
//                                     inactiveTrackColor: Colors.grey[300],
//                                     inactiveThumbColor: Colors.white,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }
// }