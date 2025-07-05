import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/components/date_input_formatter.dart';
import 'package:grd_proj/models/farm_model.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/models/inv_item_model.dart';
import 'package:grd_proj/screens/widget/text.dart';
import 'package:intl/intl.dart';

class AddItem extends StatefulWidget {
  final String farmId;
  final bool isEdit;
  final InvItemModel? item;
  const AddItem(
      {super.key, this.isEdit = false, this.item, required this.farmId});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String? selectedFarmId;
  String? selectedFieldId;
  int? selectedCategory;
  String? selectedUnit;
  FieldBloc? _fieldBloc;
  ControlBloc? _controlBloc;
  List<FieldModel>? fields;
  List<FarmModel>? farms;
  String? description;
  Map category = {
    "Fertilizer": 0,
    "Chemicals": 1,
    "Treatments": 2,
    "Produce": 3
  };
  Map measurementUnit = {"Kg": 0, "L": 1, "g": 2, "mL": 3, "Ibs": 4, "oz": 5};
  @override
  void initState() {
    context.read<FarmBloc>().add(OpenFarmEvent());
    _fieldBloc = context.read<FieldBloc>();
    _controlBloc = context.read<ControlBloc>();
    if (widget.isEdit == true && widget.item != null) {
      selectedFarmId = widget.item!.farmId;
      _fieldBloc!.add(OpenFieldEvent(farmId: selectedFarmId!));
      selectedFieldId = widget.item!.fieldId ?? '';
      selectedCategory = widget.item!.category;
      selectedUnit = widget.item!.measurementUnit;
      _controlBloc!.fieldId.text = selectedFieldId!;
      _controlBloc!.itemCategory.text = selectedCategory!.toString();
      _controlBloc!.measurementUnit.text = selectedUnit!;
      _controlBloc!.itemName.text = widget.item!.name;
      _controlBloc!.quantity.text = widget.item!.quantity.toString();
      _controlBloc!.thresholdQuantity.text =
          widget.item!.thresholdQuantity.toString();
      _controlBloc!.unitCost.text = widget.item!.unitCost.toString();
      _controlBloc!.expirationDate.text = widget.item!.expirationDate != null
          ? DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(widget.item!.expirationDate!))
          : "Not Exist";
    }
    super.initState();
  }

  @override
  void dispose() {
    _controlBloc!.fieldId.clear();
    _controlBloc!.itemCategory.clear();
    _controlBloc!.measurementUnit.clear();
    _controlBloc!.itemName.clear();
    _controlBloc!.quantity.clear();
    _controlBloc!.thresholdQuantity.clear();
    _controlBloc!.unitCost.clear();
    _controlBloc!.expirationDate.clear();
    _controlBloc!.add(OpenFarmItemsEvent(farmId: widget.farmId));
    super.dispose();
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
          _controlBloc!.itemFormKey.currentState!.validate();

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
        } else if (state is ItemEditSuccess) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item Edited Successfuly'),
              ),
            );
          });
          Navigator.pop(context);
        } else if (state is ItemEditFailure) {
          _controlBloc!.itemFormKey.currentState!.validate();

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
                        widget.isEdit
                            ? RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Update Item: ',
                                      style: TextStyle(
                                        color: primaryColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.item!.name,
                                      style: const TextStyle(
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : text(
                                fontSize: 24,
                                label: "Add New Inventory Item",
                                fontWeight: FontWeight.w600,
                                color: primaryColor),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close_rounded,
                              color: Color(0xff757575), size: 24),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    text(
                        fontSize: 20,
                        label: "Farm",
                        fontWeight: FontWeight.w600),
                    const SizedBox(
                      height: 5,
                    ),
                    BlocConsumer<FarmBloc, FarmState>(
                      listener: (context, state) {
                        if (state is FarmsLoaded) {
                          farms = state.farms;
                        } else if (state is FarmFailure) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.errMessage),
                              ),
                            );
                          });
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
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
                              items: farms?.map((farm) {
                                return DropdownMenuItem<String>(
                                  value: farm.farmId,
                                  child: Text(
                                    farm.name,
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
                                  _fieldBloc!.add(
                                      OpenFieldEvent(farmId: selectedFarmId!));
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
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    text(
                        fontSize: 20,
                        label: "Field",
                        fontWeight: FontWeight.w600),
                    const SizedBox(
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
                              content: Text('No Fields Were Found'),
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
                            items: fields?.map((field) {
                              return DropdownMenuItem<String>(
                                value: field.id,
                                child: Text(
                                  field.name,
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
                    const SizedBox(
                      height: 24,
                    ),
                    text(
                        fontSize: 20,
                        label: "Name",
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _controlBloc!.itemName,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: "Enter item Name",
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
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    text(
                        fontSize: 20,
                        label: "Category",
                        fontWeight: FontWeight.w600),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 380,
                      height: 52,
                      child: DropdownButtonFormField2<int>(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: borderColor, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: borderColor, width: 3),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 3),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 3),
                          ),
                        ),
                        isExpanded: true,
                        hint: text(
                            fontSize: 18,
                            label: "select category",
                            fontWeight: FontWeight.w600,
                            color: borderColor),
                        value: selectedCategory,
                        items: category.entries.map((cat) {
                          return DropdownMenuItem<int>(
                            value: cat.value,
                            child: Text(
                              cat.key!,
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
                            selectedCategory = value;
                            _controlBloc!.itemCategory.text =
                                selectedCategory.toString();
                          });
                        },
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
                    const SizedBox(
                      height: 24,
                    ),
                    text(
                        fontSize: 20,
                        label: "Quentity",
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controlBloc!.quantity,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: "0.00",
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
                        } else if (description != null &&
                            description!.isNotEmpty) {
                          return description;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    text(
                        fontSize: 20,
                        label: "Measurement Unit",
                        fontWeight: FontWeight.w600),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 380,
                      height: 52,
                      child: DropdownButtonFormField2<String>(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: borderColor, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: borderColor, width: 3),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 3),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 3),
                          ),
                        ),
                        isExpanded: true,
                        hint: text(
                            fontSize: 18,
                            label: "select unit",
                            fontWeight: FontWeight.w600,
                            color: borderColor),
                        value: selectedUnit,
                        items: measurementUnit.entries.map((cat) {
                          return DropdownMenuItem<String>(
                            value: cat.key,
                            child: Text(
                              cat.key!,
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
                            selectedUnit = value;
                            _controlBloc!.measurementUnit.text = selectedUnit!;
                          });
                        },
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
                    const SizedBox(
                      height: 24,
                    ),
                    text(
                        fontSize: 20,
                        label: "Treshold Quentity",
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controlBloc!.thresholdQuantity,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: "0.00",
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
                          return "Please Enter Threshold Quentity";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    text(
                        fontSize: 20,
                        label: "Unit Cost",
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controlBloc!.unitCost,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: "0.00",
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
                          return "Please Enter Unit Cost";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    text(
                        fontSize: 20,
                        label: "Expiration Date",
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controlBloc!.expirationDate,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8),
                        DateInputFormatter()
                      ],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: "YYYY-MM-DD",
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
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 100,
                              height: 45,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(0, 255, 255, 255),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: testColor,
                                  width: 1,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Cancle",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w600,
                                    color: testColor,
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (selectedFarmId == null ||
                                selectedFarmId!.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("ِAlert",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "manrope",
                                        color: primaryColor,
                                      )),
                                  backgroundColor: Colors.white,
                                  content: const Text("Please Select Farm",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "manrope",
                                        color: Colors.black,
                                      )),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancle",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "manrope",
                                            color: Colors.black,
                                          )),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "manrope",
                                            color: primaryColor,
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              if (widget.isEdit) {
                                _controlBloc!.add(EditItemEvent(
                                    farmId: selectedFarmId!,
                                    itemId: widget.item!.id));
                              } else {
                                _controlBloc!
                                    .add(AddItemEvent(farmId: selectedFarmId!));
                              }
                            }
                          },
                          child: Container(
                            width: widget.isEdit ? 160 : 120,
                            height: 45,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color(0xFF616161),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.isEdit ? "Update Farm" : "Add Item",
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.w600,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              )),
        );
      }),
    );
  }
}
