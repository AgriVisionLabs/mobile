import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/farm_model.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/screens/add_item.dart';
import 'package:grd_proj/screens/build_items.dart';
import 'package:grd_proj/screens/widget/inventory_item.dart';
import 'package:grd_proj/screens/widget/text.dart';

class InventoryManagementScreen extends StatefulWidget {
  const InventoryManagementScreen({super.key});

  @override
  State<InventoryManagementScreen> createState() =>
      _InventoryManagementScreenState();
}

class _InventoryManagementScreenState extends State<InventoryManagementScreen> {
  int selectedTab = 0;
  final List<String> tabs = [
    "All",
    "Fertilizers",
    "Chemicals",
    "Treatments",
    "Produce"
  ];
  List<FieldModel>? fields;
  String? selectedFarmId;
  List<FarmModel>? farms;
  FarmBloc? _farmBloc;

  @override
  void initState() {
    _farmBloc = context.read<FarmBloc>();
    _farmBloc!.add(OpenFarmEvent());
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
                padding: const EdgeInsets.fromLTRB(16, 150, 16, 1),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Inventory Management ",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: "manrope",
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    context.read<ControlBloc>().add(
                                        OpenFarmItemsEvent(
                                            farmId: selectedFarmId!));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddItem(
                                                  farmId: selectedFarmId!,
                                                )));
                                  }),
                            ),
                          ],
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
                                    farm.name!,
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
                                        selectedFarmId = value;
                                        context.read<ControlBloc>().add(OpenFarmItemsEvent(farmId: selectedFarmId!));
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
                        BlocBuilder<ControlBloc, ControlState>(
                          builder: (context, state) {
                            if (state is ViewItemsFailure) {
                              return const Center(
                                  child: Text('Failed to load items'));
                            }
                            if (state is ViewItemsSuccess) {
                              return SizedBox(
                                  height: 95,
                                  child: CustomScrollView(
                                      scrollDirection: Axis.horizontal,
                                      slivers: [
                                        SliverList(
                                            delegate:
                                                SliverChildBuilderDelegate(
                                                    childCount: 3,
                                                    (context, index) {
                                          return Container(
                                            width: 210,
                                            height: 92,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 3.5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 16),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: borderColor,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      text(
                                                          fontSize: 18,
                                                          label:getLabel(index)!),
                                                      const Spacer(),
                                                      Image.asset(
                                                        getImage(index)!,
                                                        height: 24,
                                                        width: 24,
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  text(
                                                      fontSize: 20,
                                                      label: getNum(state.items, index).toString(),fontWeight: FontWeight.bold)
                                                ]),
                                          );
                                        }))
                                      ]));
                            } else {
                              return SizedBox(
                                  height: 95,
                                  child: CustomScrollView(
                                      scrollDirection: Axis.horizontal,
                                      slivers: [
                                        SliverList(
                                            delegate:
                                                SliverChildBuilderDelegate(
                                                    childCount: 3,
                                                    (context, index) {
                                          return Container(
                                            width: 230,
                                            height: 92,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 3.5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 16),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: borderColor,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      text(
                                                        fontSize: 18,
                                                        label: getLabel(index)!,
                                                      ),
                                                      const Spacer(),
                                                      Image.asset(
                                                        getImage(index)!,
                                                        height: 24,
                                                        width: 24,
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  text(fontSize: 20, label: "0")
                                                ]),
                                          );
                                        }))
                                      ]));
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        Container(
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
                                        context.read<FieldBloc>().add(
                                            OpenFieldEvent(
                                                farmId: selectedFarmId!));
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
                        const SizedBox(height: 20),
                        BlocListener<FieldBloc, FieldState>(
                            listener: (context, state) {
                              if (state is FieldLoaded) {
                                fields = state.fields;
                              }
                              if (state is FieldEmpty) {
                                fields = [];
                              } else if (state is FieldFailure) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.errMessage),
                                    ),
                                  );
                                });
                              }
                            },
                            child: (selectedFarmId == null)
                                ? Center(
                                    child: text(
                                        fontSize: 24,
                                        label: "Please Select Farm",
                                        color: primaryColor),
                                  )
                                : (selectedTab == 0)
                                    ? BuildItems(
                                        farmId: selectedFarmId!,
                                      )
                                    : (selectedTab == 1)
                                        ? BuildItems(
                                            farmId: selectedFarmId!,
                                            statue: 0,
                                          )
                                        : (selectedTab == 2)
                                            ? BuildItems(
                                                farmId: selectedFarmId!,
                                                statue: 1,
                                              )
                                            : (selectedTab == 3)
                                                ? BuildItems(
                                                    farmId: selectedFarmId!,
                                                    statue: 2,
                                                  )
                                                : (selectedTab == 4)
                                                    ? BuildItems(
                                                        farmId: selectedFarmId!,
                                                        statue: 3,
                                                      )
                                                    : BuildItems(
                                                        farmId: selectedFarmId!,
                                                        statue: 4,
                                                      ))
                      ]),
                )));
      },
    );
  }
}
