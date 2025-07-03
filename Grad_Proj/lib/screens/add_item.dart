import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/farm_model.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/screens/widget/text.dart';

class AddItem extends StatefulWidget {
  final List<FarmModel> farms;
  const AddItem({super.key, required this.farms});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String? selectedFarmId;
  String? selectedFieldId;
  FieldBloc? _fieldBloc;
  ControlBloc? _controlBloc;
  List<FieldModel>? fields;
  String? description;
  @override
  void initState() {
    _fieldBloc = context.read<FieldBloc>();
    _controlBloc = context.read<ControlBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ControlBloc, ControlState>(listener: (context, state) {
        if (state is AddItemSuccess) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item Added Successfuly'),
              ),
            );
          });
          Navigator.pop(context);
        } else if (state is AddItemFailure) {
          if (state.errMessage == "Conflict") {
            description = state.errors[0]['descrption'];
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
      }, builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.only(top: 80, left: 20, right: 20),
          child: Form(
              key: _controlBloc!.itemFormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        text(
                            fontSize: 24,
                            label: "Add New Inventory Item",
                            fontWeight: FontWeight.w600,
                            color: primaryColor),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close_rounded,
                              color: Color(0xff757575), size: 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    text(
                        fontSize: 20,
                        label: "Farm",
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 380,
                      height: 52,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: text(
                              fontSize: 18,
                              label: "select farm",
                              fontWeight: FontWeight.w600,
                              color: borderColor),
                          value: selectedFarmId,
                          items: widget.farms.map((farm) {
                            return DropdownMenuItem<String>(
                              value: farm.farmId,
                              child: Text(
                                farm.name!,
                                style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedFarmId = value;
                              _fieldBloc!
                                  .add(OpenFieldEvent(farmId: selectedFarmId!));
                            });
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              border: Border.all(color: borderColor),
                            ),
                            elevation: 2,
                            offset: const Offset(0, -5),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            iconSize: 40,
                            iconEnabledColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    text(
                        fontSize: 20,
                        label: "Field",
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      height: 5,
                    ),
                    BlocConsumer<FieldBloc, FieldState>(
                        listener: (context, state) {
                      if (state is FieldLoaded) {
                        fields = state.fields;
                      } else if (state is FieldEmpty) {
                        fields = [];
                        ScaffoldMessenger.of(context).clearSnackBars();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No Fields Found'),
                            ),
                          );
                        });
                      } else if (state is FieldLoadingFailure) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errMessage),
                            ),
                          );
                        });
                      }
                    }, builder: (context, snapshot) {
                      return SizedBox(
                        width: 380,
                        height: 52,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: text(
                                fontSize: 18,
                                label: "select field",
                                fontWeight: FontWeight.w600,
                                color: borderColor),
                            value: selectedFieldId,
                            items: widget.farms.map((farm) {
                              return DropdownMenuItem<String>(
                                value: farm.farmId,
                                child: Text(
                                  farm.name!,
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (fields == null || fields!.isEmpty)
                                ? null
                                : (value) {
                                    setState(() {
                                      selectedFieldId = value;
                                      _controlBloc!.fieldId.text =
                                          selectedFieldId!;
                                    });
                                  },
                            buttonStyleData: ButtonStyleData(
                              height: 55,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border:
                                    Border.all(color: borderColor, width: 2),
                                color: Colors.white,
                              ),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(color: borderColor),
                              ),
                              elevation: 2,
                              offset: const Offset(0, -5),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              iconSize: 40,
                              iconEnabledColor: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 24,
                    ),
                    text(fontSize: 20, label: "Name" , fontWeight: FontWeight.w600),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _controlBloc!.itemName,
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
                        } else if (description!.isNotEmpty &&
                            description !=
                                "Field area is invalid or exceeds farm area.") {
                          return description;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                        width: 380,
                        height: 52,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: text(
                                fontSize: 18,
                                label: "select field",
                                fontWeight: FontWeight.w600,
                                color: borderColor),
                            value: selectedFieldId,
                            items: widget.farms.map((farm) {
                              return DropdownMenuItem<String>(
                                value: farm.farmId,
                                child: Text(
                                  farm.name!,
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (fields == null || fields!.isEmpty)
                                ? null
                                : (value) {
                                    setState(() {
                                      selectedFieldId = value;
                                      _controlBloc!.fieldId.text =
                                          selectedFieldId!;
                                    });
                                  },
                            buttonStyleData: ButtonStyleData(
                              height: 55,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border:
                                    Border.all(color: borderColor, width: 2),
                                color: Colors.white,
                              ),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(color: borderColor),
                              ),
                              elevation: 2,
                              offset: const Offset(0, -5),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              iconSize: 40,
                              iconEnabledColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24,),
                    text(fontSize: 20, label: "Quentity" , fontWeight: FontWeight.w600),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _controlBloc!.quantity,
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
                        } else if (description!.isNotEmpty &&
                            description !=
                                "Field area is invalid or exceeds farm area.") {
                          return description;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              )),
        );
      }),
    );
  }
}
