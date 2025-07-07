import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/farm_model.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/screens/build_detecion.dart';
import 'package:grd_proj/screens/widget/circule_indector.dart';
import 'package:grd_proj/screens/widget/text.dart';

class DiseaseDetection extends StatefulWidget {
  const DiseaseDetection({super.key});

  @override
  State<DiseaseDetection> createState() => _DiseaseDetectionState();
}

class _DiseaseDetectionState extends State<DiseaseDetection> {
  String? selectedFarmId;
  String? selectedFarmName;
  int selectedTab = 0;
  final List<String> tabs = [
    "All Fields",
    "Healthy",
    "Risk",
    "Infeacted",
  ];
  List<FarmModel>? farms;
  List<FieldModel>? fields;

  @override
  void initState() {
    context.read<FarmBloc>().add(OpenFarmEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FarmBloc, FarmState>(
      listener: (context, state) {
        if (state is FarmEmpty) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('There is no farms to show'),
              ),
            );
          });
        } else if (state is FarmsLoaded) {
          farms = state.farms;
          selectedFarmId = farms![0].farmId;
          selectedFarmName = farms![0].name;
          context
              .read<FieldBloc>()
              .add(OpenFieldEvent(farmId: selectedFarmId!));
          context
              .read<ControlBloc>()
              .add(OpenFarmDiseaseDetectionEvent(farmId: selectedFarmId!));
        } else if (state is FarmFailure) {
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
        return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
                padding: const EdgeInsets.fromLTRB(16, 150, 16, 0),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Disease Detection ",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: 280,
                          height: 60,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: const Text(
                                'Choose Farm',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w600),
                              ),
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
                              onChanged: (farms == null || farms!.isEmpty)
                                  ? null
                                  : (value) {
                                      setState(() {
                                        final selectedFarm = farms!
                                            .where(
                                                (farm) => farm.farmId == value)
                                            .toList();
                                        selectedFarmId = value;
                                        selectedFarmName =
                                            selectedFarm.first.name;
                                        context.read<FieldBloc>().add(
                                            OpenFieldEvent(
                                                farmId: selectedFarmId!));
                                        context.read<ControlBloc>().add(
                                            OpenFarmDiseaseDetectionEvent(
                                                farmId: selectedFarmId!));
                                      });
                                    },
                              buttonStyleData: ButtonStyleData(
                                height: 55,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: borderColor, width: 1),
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
                        const SizedBox(height: 30),
                        Center(
                          child: Container(
                            height: 62,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0x4dD9D9D9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(tabs.length, (index) {
                                  final isSelected = selectedTab == index;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 4.4),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedTab = index;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        height: 46,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          tabs[index],
                                          style: TextStyle(
                                            color: isSelected
                                                ? primaryColor
                                                : Colors.grey,
                                            fontSize: 16,
                                            fontFamily: "manrope-semi-bold",
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        (selectedFarmId == null)
                            ? Center(
                                child: text(
                                    fontSize: 24,
                                    label: "No Farms Were Found",
                                    color: primaryColor),
                              )
                            : BlocBuilder<FieldBloc, FieldState>(
                                builder: (context, state) {
                                  if (state is FieldLoadingFailure) {
                                    return text(fontSize: 50, label: "label");
                                  }
                                  if (state is FieldLoaded) {
                                    return BuildDetecions(
                                      farmId: selectedFarmId!,
                                      status: selectedTab == 0
                                          ? null
                                          : selectedTab - 1,
                                      fields: state.fields,
                                      farmName: selectedFarmName!,
                                    );
                                  } else if (state is FieldEmpty) {
                                    return BuildDetecions(
                                      farmId: selectedFarmId!,
                                      status: selectedTab == 0
                                          ? null
                                          : selectedTab - 1,
                                      fields: const [],
                                      farmName: selectedFarmName!,
                                    );
                                  }
                                  return circularProgressIndicator();
                                },
                              )
                      ]),
                )));
      },
    );
  }
}
