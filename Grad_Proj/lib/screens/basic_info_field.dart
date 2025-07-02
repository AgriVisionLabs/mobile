import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/models/crop_model.dart';
import 'package:grd_proj/models/field_model.dart';

import '../Components/color.dart';

class BasicInfoField extends StatefulWidget {
  final Function(int, FieldModel) onInputChanged;
  final int currentIndex;
  final String farmId;
  final FieldModel? field;
  final bool edit;
  final int soilType;
  const BasicInfoField(
      {super.key,
      required this.onInputChanged,
      required this.currentIndex,
      required this.farmId,
      this.edit = false,
      this.field,
      required this.soilType});

  @override
  State<BasicInfoField> createState() => _BasicInfoFieldState();
}

class _BasicInfoFieldState extends State<BasicInfoField> {
  int index = 0;
  String description = '';
  FieldBloc? _fieldBloc;
  int? selectedCropType;
  List<CropModel>? crops;
  String? cropName;
  @override
  void initState() {
    _fieldBloc = context.read<FieldBloc>();
    _fieldBloc!.add(ViewCropTypes());
    super.initState();
    if (widget.edit && widget.field != null) {
      final field = widget.field!;
      _fieldBloc!.name.text = field.name;
      _fieldBloc!.area.text = field.area.toString();
      _fieldBloc!.cropType.text = field.cropType.toString();
      selectedCropType = field.cropType;
      cropName = field.cropName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FieldBloc, FieldState>(
      listener: (context, state) {
        if (state is FieldInfoSuccess) {
          print(
              "======================================================${state.field.cropName}");
          index = widget.currentIndex;
          index++;
          widget.onInputChanged(index, state.field);
          _fieldBloc!.createFieldFormKey.currentState!.validate();
        } else if (state is FieldInfoFailure) {
          if (state.errMessage == 'Conflict' ||
              state.errMessage == "Bad Request") {
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
          _fieldBloc!.createFieldFormKey.currentState!.validate();
        }
        if (state is FieldEditSuccess) {
          index = widget.currentIndex;
          index++;
          widget.onInputChanged(index, widget.field!);
        } else if (state is FieldEditFailure) {
          if (state.errMessage == 'Conflict') {
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
          _fieldBloc!.createFieldFormKey.currentState!.validate();
        } else if (state is ViewCropTypesSuccess) {
          crops = state.crops
              .where((crop) => crop.soilType == widget.soilType)
              .toList();
        } else if (state is ViewCropTypesFailure) {
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
          height: 680,
          child: Form(
              key: _fieldBloc!.createFieldFormKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Field 1
                    const Text('Field Name',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _fieldBloc!.name,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: "Enter Field Name",
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
                          return "Please Enter Farm Name";
                        } else if (value.length < 3 || value.length > 32) {
                          return "Name must be between 3 and 100 characters.";
                        } else if (description.isNotEmpty &&
                            description !=
                                "Field area is invalid or exceeds farm area.") {
                          return description;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    ///Field 2
                    const Text('Field Size (acres)',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _fieldBloc!.area,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: "Enter Field Size",
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
                          return "Please Enter Field Size";
                        } else if (description.isNotEmpty &&
                            description !=
                                "Farm already have a field with this name.") {
                          return description;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    ///Field 3
                    const Text('Crop Type',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 5),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<int>(
                        isExpanded: true,
                        hint: Text(
                          widget.edit ? cropName! : 'Enter Crop Type',
                          style: const TextStyle(fontSize: 16),
                        ),
                        value: selectedCropType,
                        items: crops?.map((crop) {
                          return DropdownMenuItem<int>(
                            value: crop.cropType,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    crop.name,
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (crop.supportsDiseaseDetection)
                                  _buildTag("Disease Detection", Colors.green)
                                else if (crop.recommended)
                                  _buildTag("Recommended", Colors.blue)
                                else
                                  _buildTag("No Detection", Colors.grey)
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (crops == null || crops!.isEmpty)
                            ? null
                            : (value) {
                          setState(() {
                            selectedCropType = value;
                            _fieldBloc!.cropType.text =
                                selectedCropType.toString();
                          });
                        },
                        selectedItemBuilder: (crops == null || crops!.isEmpty)
                            ? null
                            : (BuildContext context) {
                                return crops!.map((crop) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      crop.name,
                                      style: const TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                        buttonStyleData: ButtonStyleData(
                          height: 55,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: borderColor, width: 2),
                            color: Colors.white,
                          ),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 250,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(color: borderColor),
                          ),
                          elevation: 2,
                          offset:
                              const Offset(0, -5), // تفتح لتحت بمسافة  من الزر
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          iconSize: 30,
                          iconEnabledColor: Colors.black,
                        ),
                      ),
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
                                if (widget.edit == true) {
                                  _fieldBloc!.add(EditFieldEvent(
                                      farmId: widget.farmId,
                                      fieldId: widget.field!.id));
                                } else {
                                  _fieldBloc!.add(
                                      CreateFieldEvent(farmId: widget.farmId));
                                }
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
                              ))),
                    )
                  ])),
        );
      },
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontFamily: 'Manrope',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
