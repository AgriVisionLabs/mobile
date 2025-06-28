import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/irrigation_view.dart';

class IrrigationDetails extends StatefulWidget {
  final String farmName;
  final String farmId;

  const IrrigationDetails(
      {super.key, required this.farmName, required this.farmId});

  @override
  State<IrrigationDetails> createState() => _IrrigationDetailsState();
}

class _IrrigationDetailsState extends State<IrrigationDetails> {
  @override
  void initState() {
    context
        .read<FieldBloc>()
        .add(OpenFarmIrrigationUnitsEvent(farmId: widget.farmId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldBloc, FieldState>(
      builder: (context, state) {
        if (state is ViewIrrigationUnitFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        } else if (state is ViewIrrigationUnitSuccess) {
          return SizedBox(
            height: 430,
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.devices.length,
                    (context, index) {
                      final item = state.devices[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: const Color.fromARGB(62, 13, 18, 28),
                                width: 1),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(50, 0, 0, 0),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                  offset: Offset(-2, 2))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 24),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/Group.png',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(item.name,
                                          style: const TextStyle(
                                            color: Color(0xff1E6930),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "manrope",
                                          )),
                                      const Spacer(),
                                      Container(
                                        width: 77,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                color: borderColor, width: 1)),
                                        child: Center(
                                          child: Text(
                                            item.status == 2
                                                ? "Active"
                                                : "Inactive",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/location.png',
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                          "${widget.farmName} - ${item.fieldName}",
                                          style: const TextStyle(
                                            color: Color(0xff616161),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "manrope",
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      const Text("Firmware:  ",
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(212, 97, 97, 97),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "manrope",
                                          )),
                                      Text(item.firmWareVersion,
                                          style: const TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "manrope",
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  const Row(
                                    children: [
                                      SizedBox(width: 8),
                                      Text("Power:  ",
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(212, 97, 97, 97),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "manrope",
                                          )),
                                      Text("24V / 120W",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "manrope",
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  const Row(
                                    children: [
                                      SizedBox(width: 8),
                                      Text("Last Operation:  ",
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(212, 97, 97, 97),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "manrope",
                                          )),
                                      SizedBox(
                                        width: 160,
                                        height: 60,
                                        child:
                                            Text("Zone 3 active for 20 minutes",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "manrope",
                                                )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color.fromARGB(63, 13, 18, 28),
                              thickness: 1,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("maintaince");
                                    },
                                    child: Image.asset(
                                        'assets/images/Vector2.png',
                                        width: 30,
                                        height: 30),
                                  ),
                                  const SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                IrrigationView(
                                                  irrigationDevice: item,
                                                )),
                                      );
                                    },
                                    child: Image.asset(
                                        'assets/images/shape.png',
                                        width: 30,
                                        height: 30),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<FieldBloc>()
                                          .add(DeleteIrrigationUnitEvent(
                                            farmId: item.farmId,
                                            fieldId: item.fieldId,
                                          ));
                                      // ignore: avoid_print
                                      print("==========Delted===========");
                                      context.read<FieldBloc>().add(
                                          OpenFarmIrrigationUnitsEvent(
                                              farmId: item.farmId));
                                    },
                                    child: Image.asset(
                                        'assets/images/delete.png',
                                        color: Colors.red,
                                        width: 30,
                                        height: 30),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is IrrigationUnitEmpty) {
          return const SizedBox(
              child: Center(
                  child: Text('No Irrigation units found',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontFamily: "manrope",
                        color: primaryColor,
                      ))));
        }
        return const SizedBox(
            child: Center(
                child: CircularProgressIndicator(
          color: primaryColor,
        )));
      },
    );
  }
}
