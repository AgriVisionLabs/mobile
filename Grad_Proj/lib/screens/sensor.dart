// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/models/sensor_model.dart';
import 'package:grd_proj/screens/qr_scan.dart';

import '../Components/color.dart';

class Sensor extends StatefulWidget {
  final Function(int) onInputChanged;
  final int currentIndex;
  final String fieldId;
  final String farmId;
  final bool form;
  const Sensor(
      {super.key,
      required this.onInputChanged,
      required this.currentIndex,
      required this.farmId,
      required this.fieldId,
      required this.form});

  @override
  State<Sensor> createState() => _SensorState();
}

class _SensorState extends State<Sensor> {
  List<Map<String, dynamic>> mySensorList = [];
  TextEditingController? serialNumberController;
  bool addOne = true;
  int index = 0;
  String description = '';
  SensorDevice? devices;
  FieldBloc? _fieldBloc;
  void _onInputChanged(String serialNumScaned) {
    setState(() {
      print(
          '=====================test=================$serialNumScaned======================================');
      serialNumberController = TextEditingController(text: serialNumScaned);
    });
  }

  @override
  void initState() {
    _fieldBloc = context.read<FieldBloc>();
    _fieldBloc!.add(OpenFarmSensorUnitsEvent(farmId: widget.farmId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FieldBloc, FieldState>(
      listener: (context, state) {
        if (state is AddSensorUnitFailure) {
          _fieldBloc!.addSensorUnitFormKey.currentState!.validate();
          if (state.errMessage == 'Conflict' ||
              state.errMessage == 'Not Found') {
            description = state.errors[0]['description'];
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(description),
                ),
              );
            });
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMessage),
                ),
              );
            });
          }
        }
        if (state is AddSensorUnitSuccess) {
          _fieldBloc!.addSensorUnitFormKey.currentState!.validate();
          if (widget.form == false) {
            index = widget.currentIndex;
            index++;
            widget.onInputChanged(index);
            Navigator.pop(context);
          } else {
            devices = state.device;
            _fieldBloc!.sensorId.text = state.device.id;
            addOne = !addOne;
            mySensorList.add({
              'name': _fieldBloc!.sensorUnitName.text,
              'number': _fieldBloc!.sensorSerialNum.text,
            });
          }
        } else if (state is ViewFieldSensorUnitSuccess) {
          _fieldBloc!.sensorUnitName.text = state.device.name;
          _fieldBloc!.sensorSerialNum.text = state.device.serialNumber;
          addOne = !addOne;
          mySensorList.add({
            'name': context.read<FieldBloc>().irrigationUnitName.text,
            'number': context.read<FieldBloc>().irrigationSerialNum.text,
          });
        } else if (state is ViewFieldSensorUnitFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        }
      },
      builder: (context, state) {
        return Container(
          color: Colors.white,
          width: 380,
          height: widget.form ? 670 : 630,
          child: Form(
              key: context.read<FieldBloc>().addSensorUnitFormKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Field 1
                    const Text('Sensor Unit Name',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: context.read<FieldBloc>().sensorUnitName,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: "Enter Sensor Unit Name",
                        hintStyle: const TextStyle(color: borderColor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: borderColor, width: 3.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 3.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: errorColor, width: 3.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: errorColor, width: 3.0),
                        ),
                      ),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Sensor Unit Name";
                        } else if (value.length < 3 || value.length > 100) {
                          return "must be between 30 and 100 characters. You entered 2 characters.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    ///Field 2
                    const Text('Serial Number',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 380,
                      height: 60,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 297,
                            height: 60,
                            child: TextFormField(
                              controller: serialNumberController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 17),
                                hintText: "Enter Serial Number",
                                hintStyle: const TextStyle(color: borderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(
                                      color: borderColor, width: 3.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(
                                      color: primaryColor, width: 3.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(
                                      color: errorColor, width: 3.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(
                                      color: errorColor, width: 3.0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Serial Number";
                                } else if (description.isNotEmpty) {
                                  return description;
                                } else if (value.length < 10 ||
                                    value.length > 25) {
                                  return "must be between 10 and 25 characters. You entered 2 characters.";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _fieldBloc!.sensorSerialNum.text = value;
                                });
                              },
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: borderColor,
                                  width: 2,
                                ),
                                color: Colors.white),
                            child: IconButton(
                                onPressed: () {
                                  //add qr code handeler
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QrScan(
                                              onInputChanged:
                                                  _onInputChanged)));
                                },
                                icon: const Center(
                                    child: Icon(
                                  Icons.qr_code_2,
                                  size: 30,
                                  color: borderColor,
                                ))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    widget.form
                        ? Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: addOne ? primaryColor : borderColor,
                            ),
                            child: TextButton(
                                onPressed: () {
                                  if (addOne == true) {
                                    context.read<FieldBloc>().add(
                                        AddSensorUnitEvent(
                                            farmId: widget.farmId,
                                            fieldId: widget.fieldId));
                                  } else {
                                    print('Please Enter requested info');
                                  }
                                },
                                child: const SizedBox(
                                  width: 380,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 3),
                                      Icon(Icons.add,
                                          color: Colors.white, size: 20),
                                      Text(
                                        'Add',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )))
                        : const SizedBox(
                            height: 0,
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    mySensorList.isNotEmpty
                        ? _buildSensorList()
                        : const SizedBox(
                            height: 1,
                          ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor,
                          ),
                          child: widget.form
                              ? TextButton(
                                  onPressed: () {
                                    index = widget.currentIndex;
                                    index++;
                                    widget.onInputChanged(index);
                                  },
                                  child: const SizedBox(
                                    width: 70,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Next',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: 3),
                                        Icon(Icons.arrow_forward_ios,
                                            color: Colors.white, size: 20),
                                      ],
                                    ),
                                  ))
                              : TextButton(
                                  onPressed: () {
                                    context.read<FieldBloc>().add(
                                        AddIrrigationUnitEvent(
                                            farmId: widget.farmId,
                                            fieldId: widget.fieldId));

                                    context
                                        .read<FieldBloc>()
                                        .add(OpenFarmSensorUnitsEvent(
                                          farmId: widget.farmId,
                                        ));
                                  },
                                  child: const SizedBox(
                                    width: 60,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Save',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))),
                    )
                  ])),
        );
      },
    );
  }

  Widget _buildSensorList() {
    return SizedBox(
      width: 380,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Added Sensor Unit',
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
                padding: const EdgeInsets.all(0),
                itemCount: mySensorList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    width: 380,
                    height: 110,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(30, 105, 48, 0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Task Descrption
                          Text(
                            mySensorList[index]['name'],
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              // decoration: TextDecoration.lineThrough
                            ),
                          ),

                          Align(
                            heightFactor: 1,
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 20,
                              height: 30,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      mySensorList.removeAt(index);
                                      context.read<FieldBloc>().add(
                                          DeleteSensorUnitEvent(
                                              farmId: widget.farmId,
                                              fieldId: widget.fieldId,
                                              sensorId: devices!.id));
                                      addOne = !addOne;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 18,
                                  )),
                            ),
                          ),

                          Text('${mySensorList[index]['number']}',
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                color: borderColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
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
