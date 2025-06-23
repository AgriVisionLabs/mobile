import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';

class IrrigationDevices extends StatefulWidget {
  final String farmName;
  final String farmId;

  const IrrigationDevices(
      {super.key, required this.farmName, required this.farmId});

  @override
  State<IrrigationDevices> createState() => _IrrigationDevicesState();
}

class _IrrigationDevicesState extends State<IrrigationDevices> {
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
            height: state.devices.length == 1 ? 250 : 520,
            child: CustomScrollView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                                color:
                                    const Color(0xff0D121C).withOpacity(0.25),
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
                            SizedBox(height: 24,),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24),
                              child: Row(
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
                                        borderRadius: BorderRadius.circular(25),
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
                            ),
                            const SizedBox(height: 16),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/location.png',
                                  ),
                                  const SizedBox(width: 8),
                                  Text(item.fieldName,
                                      style: TextStyle(
                                        color: Color(0xff616161),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "manrope",
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/ha4tag.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(item.name,
                                      style: TextStyle(
                                        color: Color(0xff0D121C),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "manrope",
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(
                              color: const Color(0xff0D121C).withOpacity(0.25),
                              thickness: 1,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("edit it");
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
                                      context.read<FieldBloc>().add(
                                          OpenFarmIrrigationUnitsEvent(
                                              farmId: item.farmId));
                                    },
                                    child: Image.asset('assets/images/delete.png',
                                        width: 30, height: 30),
                                  ),
                                  const Spacer(),
                                  Switch(
                                    value: item.status == 2,
                                    onChanged: (value) {
                                      context.read<FieldBloc>().add(
                                          IrrigationUnitsEditEvent(
                                              fieldId: item.fieldId,
                                              farmId: item.farmId,
                                              name: item.name,
                                              status: item.status == 2 ? 1 : 2,
                                              newFieldId: item.fieldId));
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
