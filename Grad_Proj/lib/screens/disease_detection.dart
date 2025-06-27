import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/farm_model.dart';

class DiseaseDetection extends StatefulWidget {
  const DiseaseDetection({super.key});

  @override
  State<DiseaseDetection> createState() => _DiseaseDetectionState();
}

class _DiseaseDetectionState extends State<DiseaseDetection> {
  String? selectedFarmId;
  String? selectedFarmName;
  bool isAllFields = true , isHealthy=false , isRisk=false , isInfeacted=false ;
  List<FarmModel>? farms;
  @override
  Widget build(BuildContext context) {
    context.read<FarmBloc>().add(OpenFarmEvent());
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
            body: Container(
                margin: const EdgeInsets.only(top: 22, left: 10, right: 10),
                height: MediaQuery.sizeOf(context).height,
                child: ListView(scrollDirection: Axis.vertical, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text(
                      "Disease Detection",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "manrope",
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
                          width: 289,
                          height: 53,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: borderColor, width: 1)),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                            value: selectedFarmId,
                            isExpanded: true,
                            icon: Image.asset(
                              'assets/images/arrow.png',
                            ),
                            onChanged: (farms == null || farms!.isEmpty)
                                ? null
                                : (newValue) {
                                    final selectedFarm = farms!
                                        .where(
                                            (farm) => farm.farmId == newValue)
                                        .toList();
                                    if (selectedFarm.isNotEmpty) {
                                      setState(() {
                                        selectedFarmId = newValue;
                                        selectedFarmName =
                                            selectedFarm.first.name;
                                        
                                      });
                                    }
                                  },
                            items: farms?.map<DropdownMenuItem<String>>((farm) {
                              return DropdownMenuItem<String>(
                                value: farm.farmId,
                                child: Text(farm.name!),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                  height: 24,
                ),
                Container(
                  width: 405,
                  height: 62,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(43, 159, 159, 159),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: 97,
                        decoration: BoxDecoration(
                          color: isAllFields
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isAllFields = true;
                              isHealthy = false;
                              isRisk = false;
                              isInfeacted = false;
                            });
                          },
                          child: Text(
                            "All Fields",
                            style: TextStyle(
                              color:
                                  isAllFields ? primaryColor : borderColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "manrope",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: 97,
                        decoration: BoxDecoration(
                          color: isHealthy
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isAllFields = false;
                              isHealthy = true;
                              isRisk = false;
                              isInfeacted = false;
                            });
                          },
                          child: Text(
                            "Healthy",
                            style: TextStyle(
                              color:
                                  isHealthy ? primaryColor : borderColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "manrope",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: 97,
                        decoration: BoxDecoration(
                          color: isRisk
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isAllFields = false;
                              isHealthy = false;
                              isRisk = true;
                              isInfeacted = false;
                            });
                          },
                          child: Text(
                            "At Risk",
                            style: TextStyle(
                              color:
                                  isRisk ? primaryColor : borderColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "manrope",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: 97,
                        decoration: BoxDecoration(
                          color: isInfeacted
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isAllFields = false;
                              isHealthy = false;
                              isRisk = false;
                              isInfeacted = true;
                            });
                          },
                          child: Text(
                            "Infeacted",
                            style: TextStyle(
                              color:
                                  isInfeacted ? primaryColor : borderColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "manrope",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  ])
                ])));
      },
    );
  }
}
