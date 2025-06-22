// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
// import 'package:grd_proj/components/color.dart';

// class AutomationRules extends StatefulWidget {
//   final String farmName;
//   final String farmId;
//   const AutomationRules({super.key, required this.farmName, required this.farmId});

//   @override
//   State<AutomationRules> createState() => _AutomationRulesState();
// }

// class _AutomationRulesState extends State<AutomationRules> {
//   @override
//  Widget build(BuildContext context) {
//     context
//         .read<FieldBloc>()
//         .add(OpenFarmAutomationRulesEvent(farmId: widget.farmId));
//     return BlocBuilder<FieldBloc, FieldState>(
//       builder: (context, state) {
//         if (state is ViewAutomationRulesFailure) {
//           ScaffoldMessenger.of(context).clearSnackBars();
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.errMessage),
//               ),
//             );
//           });
//         } else if (state is ViewAutomationRulesSuccess) {
//           return SizedBox(
//             height: state.rules.length == 1 ? 250 : 520,
//             child: CustomScrollView(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               slivers: [
//                 SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     childCount: state.rules.length,
//                     (context, index) {
//                       final item = state.rules[index];
//                       return Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 20, horizontal: 15),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(25),
//                             border: Border.all(
//                                 color:
//                                     const Color(0xff0D121C).withOpacity(0.25),
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
//                             Text(widget.farmName,
//                                 style: const TextStyle(
//                                   color: Color(0xff1E6930),
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: "manrope",
//                                 )),
//                             const SizedBox(height: 16),
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/images/location.png',
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(item.fieldName,
//                                     style: TextStyle(
//                                       color: Color(0xff616161),
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily: "manrope",
//                                     )),
//                               ],
//                             ),
//                             const SizedBox(height: 16),
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/images/ha4tag.png',
//                                   width: 24,
//                                   height: 24,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(item.name,
//                                     style: TextStyle(
//                                       color: Color(0xff0D121C),
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily: "manrope",
//                                     )),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             Divider(
//                               color: const Color(0xff0D121C).withOpacity(0.25),
//                               thickness: 1,
//                             ),
//                             const SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     print("edit it");
//                                   },
//                                   child: Image.asset('assets/images/edit.png',
//                                       width: 30, height: 30),
//                                 ),
//                                 const SizedBox(width: 20),
//                                 GestureDetector(
//                                   onTap: () {
//                                     context
//                                         .read<FieldBloc>()
//                                         .add(DeleteIrrigationUnitEvent(
//                                           farmId: item.farmId,
//                                           fieldId: item.fieldId,
//                                         ));
//                                   },
//                                   child: Image.asset('assets/images/delete.png',
//                                       width: 30, height: 30),
//                                 ),
//                                 const Spacer(),
//                                 Switch(
//                                   value: item.status == 1,
//                                   onChanged: (value) {
//                                     context.read<FieldBloc>().add(
//                                         IrrigationUnitsEditEvent(
//                                             fieldId: item.fieldId,
//                                             farmId: item.farmId,
//                                             name: item.name,
//                                             status: value ? 2 : 1,
//                                             newFieldId: item.fieldId));
//                                   },
//                                   activeColor: Colors.white,
//                                   activeTrackColor: primaryColor,
//                                   inactiveTrackColor: Colors.grey[300],
//                                   inactiveThumbColor: Colors.white,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else if (state is IrrigationUnitEmpty) {
//           return const SizedBox(
//               child: Center(
//                   child: Text('No irrigation units found',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: "manrope",
//                         color: primaryColor,
//                       ))));
//         }
//         return const SizedBox(
//             child: Center(
//                 child: CircularProgressIndicator(
//           color: primaryColor,
//         )));
//       },
//     );
//   }
// }