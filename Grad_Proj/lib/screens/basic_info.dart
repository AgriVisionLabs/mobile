import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';

import '../Components/color.dart';

class BasicInfo extends StatefulWidget {
  final Function(int) onInputChanged;
  final int currentIndex;
  final bool editFarm;
  const BasicInfo(
      {super.key,
      required this.onInputChanged,
      required this.currentIndex,
      this.editFarm = false});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  GlobalKey<FormState> formstate = GlobalKey();
  String? selectedValue;
  int index = 0;
  List farm = [];
  Map soil = {'Sandy': 1, 'Clay': 2, 'Loamy': 3};
  List editFarm = ['Green Farm', '900', 'Ismailia', 'Clay'];
  String description = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FarmBloc, FarmState>(
      listener: (context, state) {
        if (state is FarmInfoSuccess) {
          index = widget.currentIndex;
          index++;
          widget.onInputChanged(index);
        } else if (state is FarmFailure) {
          if (state.errMessage == 'Conflict') {
            description = state.errors[0]['description'];
          } ScaffoldMessenger.of(context).clearSnackBars();
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
          height: 680,
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
                        hintText:
                            widget.editFarm ? editFarm[0] : "Enter Farm Name",
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
                                  borderSide: const BorderSide(
                                      color: errorColor, width: 3.0),
                                ),
                      ),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Farm Name";
                        }else if(description.isNotEmpty){
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
                        hintText:
                            widget.editFarm ? editFarm[1] : "Enter Farm Size",
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
                                  borderSide: const BorderSide(
                                      color: errorColor, width: 3.0),
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
                            ? editFarm[2]
                            : "Enter Farm Location",
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
                                  borderSide: const BorderSide(
                                      color: errorColor, width: 3.0),
                                ),
                      ),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Farm Location";
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
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        hint: Text(widget.editFarm ? editFarm[3] : 'Soil Type'),
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
                          });
                        },
                        items:
                            soil.entries.map<DropdownMenuItem<String>>((entry) {
                          return DropdownMenuItem(
                            value: entry.value.toString(),
                            child: Text(entry.key),
                          );
                        }).toList(),
                      ),
                    ),
                    const Spacer(),
                    widget.editFarm
                        ? const SizedBox(
                            height: 1,
                          )
                        : Align(
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
                                      setState(() {
                                        if (selectedValue == null) {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Please Enter Soil Type"),
                                              ),
                                            );
                                          });
                                        } else if (widget.editFarm == true) {
                                          index = widget.currentIndex;
                                          index++;
                                          widget.onInputChanged(index);
                                        } else {
                                          context
                                              .read<FarmBloc>()
                                              .soilType
                                              .text = selectedValue!;
                                          context
                                              .read<FarmBloc>()
                                              .add(CreateFarmEvent());
                                        }
                                      });
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
