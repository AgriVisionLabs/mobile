import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/irrigation_model.dart';
import 'package:grd_proj/screens/irrigation_edit.dart';

class IrrigationDevices extends StatefulWidget {
  final String farmName;
  final String farmId;
  final String? fieldId;
  final String? statue;
  const IrrigationDevices(
      {super.key,
      required this.farmName,
      required this.farmId,
      this.fieldId,
      this.statue});

  @override
  State<IrrigationDevices> createState() => _IrrigationDevicesState();
}

class _IrrigationDevicesState extends State<IrrigationDevices> {
  List<IrrigationDevice>? myDevices;
  int? tell;
  String ? description;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FieldBloc, FieldState>(
      listener: (context, state) {
        if (state is IrrigationUnitToggleSuccess) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:  Text("Irrigation unit switched on"),
              ),
            );
          });
        }else if (state is IrrigationUnitToggleFailure) {
          description = state.errors[0]['description'];
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content:  Text(description!),
              ),
            );
          });
        }
      },
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
          if (widget.fieldId != null && widget.statue != null) {
            if (widget.fieldId!.isNotEmpty && widget.statue!.isNotEmpty) {
              tell = widget.statue == "Active" ? 1 : 2;
              myDevices = state.devices
                  .where((device) =>
                      device.fieldId == widget.fieldId && device.status == tell)
                  .toList();
            } else if (widget.fieldId!.isNotEmpty && widget.statue!.isEmpty) {
              myDevices = state.devices
                  .where((device) => device.fieldId == widget.fieldId)
                  .toList();
            } else if (widget.statue!.isEmpty) {
              tell = widget.statue == "Active" ? 1 : 2;
              myDevices = state.devices
                  .where((device) => device.status == tell)
                  .toList();
            }
          } else {
            myDevices = state.devices;
          }
          return SizedBox(
            height: myDevices!.length == 1 ? 250 : 520,
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: myDevices!.length,
                    (context, index) {
                      final item = myDevices![index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.only(top: 24),
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
                                  spreadRadius: 0.7,
                                  offset: Offset(0, 2.25))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(widget.farmName,
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
                                            item.status == 0
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
                                      Text(item.fieldName,
                                          style: const TextStyle(
                                            color: Color(0xff616161),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "manrope",
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/ha4tag.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(item.name,
                                          style: const TextStyle(
                                            color: Color(0xff0D121C),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "manrope",
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                IrrigationEdit(
                                                  farm: item.farmId,
                                                  field: item.fieldId,
                                                )),
                                      );
                                    },
                                    child: Image.asset('assets/images/edit.png',
                                        width: 30, height: 30),
                                  ),
                                  const SizedBox(width: 20),
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
                                        width: 30,
                                        height: 30),
                                  ),
                                  const Spacer(),
                                  Switch(
                                    value: item.isOn,
                                    onChanged: (value) {
                                      context
                                          .read<FieldBloc>()
                                          .add(IrrigationUnitToggleEvent(
                                            fieldId: item.fieldId,
                                            farmId: item.farmId,
                                          ));
                                      context.read<FieldBloc>().add(
                                          OpenFarmIrrigationUnitsEvent(
                                              farmId: item.farmId));
                                    },
                                    activeColor: Colors.white,
                                    activeTrackColor: primaryColor,
                                    inactiveTrackColor: Colors.grey[300],
                                    inactiveThumbColor: Colors.white,
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
                  child: Text('No irrigation units found',
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
