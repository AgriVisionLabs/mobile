
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';

import '../Components/color.dart';

class ReviewField extends StatefulWidget {
  final String farmId;
  final String fieldId;
  final bool? edit;
  const ReviewField({super.key, required this.fieldId, required this.farmId, this.edit=false});

  @override
  State<ReviewField> createState() => _ReviewFieldState();
}

class _ReviewFieldState extends State<ReviewField> {
  FieldBloc? _fieldBloc;
  @override
  void initState() {
    _fieldBloc = context.read<FieldBloc>();
    _fieldBloc!.add(OpenFieldIrrigationUnitsEvent(
        farmId: widget.farmId, fieldId: widget.fieldId));
    if (_fieldBloc!.sensorId.text.isNotEmpty) {
      _fieldBloc!.add(OpenFieldSensorUnitsEvent(
          farmId: widget.farmId,
          fieldId: widget.fieldId,
          sensorId: _fieldBloc!.sensorId.text));
    }
    _fieldBloc!
        .add(ViewFieldDetails(farmId: widget.farmId, fieldId: widget.fieldId));
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FieldBloc, FieldState>(
      listener: (BuildContext context, FieldState state) {
        if (state is ViewFieldIrrigationUnitSuccess) {
          _fieldBloc!.irrigationSerialNum.text = state.device.serialNumber;
          _fieldBloc!.irrigationUnitName.text = state.device.name;
        } else if (state is ViewFieldSensorUnitSuccess) {
          _fieldBloc!.sensorSerialNum.text = state.device.serialNumber;
          _fieldBloc!.sensorUnitName.text = state.device.name;
        }
      },
      builder: (context, state) {
        if (state is FieldFailure) {
          return Center(
            child: Text('Sonething went wrong',
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  // decoration: TextDecoration.lineThrough
                )),
          );
        } else if (state is FieldSuccess) {
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
                    Text(state.field.name,
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
                    Text('${state.field.area} acres',
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
                  Text(state.field.cropName ?? "Not Specified",
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
              context.read<FieldBloc>().irrigationSerialNum.text.isNotEmpty
                  ? _buildDevicesList(false)
                  : SizedBox(
                      height: 0,
                    ),
              context.read<FieldBloc>().sensorSerialNum.text.isNotEmpty
                  ? _buildDevicesList(true)
                  : SizedBox(
                      height: 0,
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
                        },
                        child: Text(
                          widget.edit! ? "Edit Field":
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
        }
        return Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        );
      },
    );
  }

  Widget _buildDevicesList(bool isSensor) {
    return SizedBox(
        width: 380,
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(!isSensor ? 'Irrigation Units' : 'Sensor Units',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            Container(
              height: 76,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(30, 105, 48, 0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Task Descrption
                    Text(
                      !isSensor
                          ? context.read<FieldBloc>().irrigationUnitName.text
                          : context.read<FieldBloc>().sensorUnitName.text,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        // decoration: TextDecoration.lineThrough
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),

                    Text(
                        !isSensor
                            ? context.read<FieldBloc>().irrigationSerialNum.text
                            : context.read<FieldBloc>().sensorSerialNum.text,
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          color: borderColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          // decoration: TextDecoration.lineThrough
                        ))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
