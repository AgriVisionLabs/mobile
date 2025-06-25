import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/bloc/control_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';

class Rules extends StatefulWidget {
  final Function(int) onInputChanged;
  final int currentIndex;
  final String fieldId;
  final String farmId;
  final bool form;
  const Rules(
      {super.key,
      required this.onInputChanged,
      required this.currentIndex,
      required this.farmId,
      required this.fieldId,
      required this.form});

  @override
  State<Rules> createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  String? selectedtype;
  int? type;
  String? description;
  int index = 0;
  List<String> rules_types = [
    "Threshold",
    "Schedualed",
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ControlBloc, ControlState>(
      listener: (context, state) {
        if (state is AddAutomationRulesFailure) {
          context.read<ControlBloc>().ruleFormKey.currentState!.validate();
          if (state.errMessage == 'Conflict' ||
              state.errMessage == 'Not Found') {
            description = state.errors[0]['description'];
          }
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        }
        if (state is AddAutomationRulesSuccess) {
          index = widget.currentIndex;
          index++;
          widget.onInputChanged(index);
          context.read<ControlBloc>().add(OpenFarmAutomationRulesEvent(
                farmId: widget.farmId,
              ));
          context.read<FieldBloc>().add(OpenFarmIrrigationUnitsEvent(
                farmId: widget.farmId,
              ));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return SizedBox(
            width: 390,
            height: 665,
            child: Form(
                key: context.read<ControlBloc>().ruleFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rule Name',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: context.read<ControlBloc>().ruleName,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: "Enter Rule Name",
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
                          return "Please Enter Irrigation Unit Name";
                        } else if (value.length < 3 || value.length > 100) {
                          return "must be between 30 and 100 characters. You entered 2 characters.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('Rule Type',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      width: 390,
                      height: 53,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: borderColor, width: 2.5)),
                      child: DropdownButton<String>(
                        hint: const Text("All Types",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: "manrope",
                            )),
                        dropdownColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        value: selectedtype,
                        isExpanded: true,
                        icon: Image.asset(
                          'assets/images/arrow.png',
                          color: borderColor,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedtype = newValue;
                            type = newValue == "Threshold" ? 0 : 1;
                            context.read<ControlBloc>().type.text =
                                type.toString();
                          });
                        },
                        items: rules_types.map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                      ),
                    ),
                    type == null
                        ? const SizedBox(
                            height: 0,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                  type == 1
                                      ? "Start irrigationt time"
                                      : 'Start irrigation threshold',
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  )),
                              const SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: context
                                    .read<ControlBloc>()
                                    .minThresholdValue,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 17),
                                  hintText: type == 1
                                      ? "HH:MM:SS"
                                      : "Enter Max Threshold Limit",
                                  hintStyle:
                                      const TextStyle(color: borderColor),
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
                                    return "Please Enter Irrigation Unit Name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(
                                  type == 1
                                      ? "End irrigationt time"
                                      : 'Stop irrigation threshold',
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  )),
                              const SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: context
                                    .read<ControlBloc>()
                                    .maxThresholdValue,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 17),
                                  hintText: type == 1
                                      ? "HH:MM:SS"
                                      : "Enter Min Threshold Limit",
                                  hintStyle:
                                      const TextStyle(color: borderColor),
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
                                    return "Please Enter Irrigation Unit Name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(type == 1 ? " Activation Days " : 'Unit',
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  )),
                              const SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: context
                                    .read<ControlBloc>()
                                    .targetSensorType,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 17),
                                  hintText: type == 1
                                      ? "Number of Activate Days"
                                      : "Enter Unit",
                                  hintStyle:
                                      const TextStyle(color: borderColor),
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
                                    return "Please Enter Unit";
                                  }
                                  return null;
                                },
                              ),
                            ],
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
                          child: TextButton(
                              onPressed: () {
                                if (context
                                    .read<ControlBloc>()
                                    .type
                                    .text
                                    .isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Please Enter Rule Type"),
                                      ),
                                    );
                                  });
                                } else {
                                  context.read<ControlBloc>().add(
                                      AddAutomationRulesEvent(
                                          farmId: widget.farmId,
                                          fieldId: widget.fieldId));
                                }
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
                  ],
                )));
      },
    );
  }
}
