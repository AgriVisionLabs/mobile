// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/models/farm_model.dart';

import '../Components/color.dart';

class BasicInfo extends StatefulWidget {
  final Function(int, String) onInputChanged;
  final int currentIndex;
  final bool editFarm;
  final FarmModel? farm;
  const BasicInfo(
      {super.key,
      required this.onInputChanged,
      required this.currentIndex,
      this.editFarm = false,
      this.farm});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  int? selectedValue;
  int index = 0;
  Map soil = {'Sandy': 1, 'Clay': 2, 'Loamy': 3};
  String? getSoilName(int soiltype) {
    return soil.entries
        .firstWhere(
          (entry) => entry.value == soiltype,
          orElse: () => const MapEntry('Unknown', null),
        )
        .key;
  }

  String? soilName;
  String description = '';

  @override
  void initState() {
    super.initState();
    if (widget.editFarm && widget.farm != null) {
      final farm = widget.farm!;
      context.read<FarmBloc>().name.text = farm.name ?? '';
      context.read<FarmBloc>().area.text = farm.area?.toString() ?? '';
      context.read<FarmBloc>().location.text = farm.location ?? '';
      selectedValue = farm.soilType;
      soilName = getSoilName(farm.soilType!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FarmBloc, FarmState>(
      listener: (context, state) {
        if (state is FarmEditSuccess) {
          index = widget.currentIndex;
          index++;
          widget.onInputChanged(index, widget.farm!.farmId!);
          context
              .read<FarmBloc>()
              .add(ViewFarmMembers(farmId: widget.farm!.farmId!));
        } else if (state is FarmEditFailure) {
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
          context.read<FarmBloc>().createFarmFormKey.currentState!.validate();
        }
        if (state is FarmInfoSuccess) {
          context.read<FarmBloc>().createFarmFormKey.currentState!.validate();
          context
              .read<FarmBloc>()
              .add(ViewFarmMembers(farmId: state.farm.farmId!));
          index = widget.currentIndex;
          index++;
          widget.onInputChanged(index, state.farm.farmId!);
        } else if (state is FarmInfoFailure) {
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
          context.read<FarmBloc>().createFarmFormKey.currentState!.validate();
        }
      },
      builder: (context, state) {
        return Container(
          color: Colors.white,
          width: 380,
          height: 660,
          child: Form(
              key: context.read<FarmBloc>().createFarmFormKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Field 1
                    const Text('Farm Name',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: context.read<FarmBloc>().name,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: widget.editFarm
                            ? widget.farm!.name
                            : "Enter Farm Name",
                        hintStyle: widget.editFarm
                            ? const TextStyle(color: Colors.black)
                            : const TextStyle(color: borderColor),
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
                        } else if (description.isNotEmpty) {
                          return description;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    ///Field 2
                    const Text('Farm Size (acres)',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: context.read<FarmBloc>().area,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: widget.editFarm
                            ? "${widget.farm?.area} "
                            : "Enter Farm Size",
                        hintStyle: widget.editFarm
                            ? const TextStyle(color: Colors.black)
                            : const TextStyle(color: borderColor),
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
                          return "Please Enter Farm Size";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    ///Field 3
                    const Text('Farm Location',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: context.read<FarmBloc>().location,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: widget.editFarm
                            ? widget.farm!.location
                            : "Enter Farm Location",
                        hintStyle: widget.editFarm
                            ? const TextStyle(color: Colors.black)
                            : const TextStyle(color: borderColor),
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
                          return "Please Enter Farm Location";
                        } else if (value.length < 3 || value.length > 32) {
                          return "Location must be between 3 and 100 characters. You entered 2 characters.";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    ///Field 4
                    const Text('Soil Type',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 1),
                      width: 390,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: borderColor, width: 3)),
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        hint: Text(widget.editFarm ? soilName! : 'Soil Type'),
                        style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: borderColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                        value: selectedValue,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: borderColor,
                          size: 40,
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                            context.read<FarmBloc>().soilType.text = selectedValue.toString();
                          });
                        },
                        items: soil.entries.map<DropdownMenuItem<int>>((entry) {
                          return DropdownMenuItem(
                            value: entry.value,
                            child: Text(entry.key),
                          );
                        }).toList(),
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
                                if (widget.editFarm) {
                                  // Edit event
                                  context.read<FarmBloc>().add(
                                        EditFarmEvent(
                                          farmId: widget.farm!.farmId!,
                                        ),
                                      );
                                } else {
                                  // Create event
                                  context.read<FarmBloc>().soilType.text =
                                      selectedValue.toString();
                                  context
                                      .read<FarmBloc>()
                                      .add(CreateFarmEvent());
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
}
