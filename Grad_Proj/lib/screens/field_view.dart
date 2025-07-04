/// The `FieldView` class in Dart is a StatefulWidget that displays detailed information about a field,
/// including area, crop name, growth progress, days until harvest, timeline, and description, fetched
/// from a Bloc state.
///
/// Args:
///   apiDateString (DateTime): The `apiDateString` parameter in the `calculateDaysDifference` function
/// is a `DateTime` object representing a date obtained from an API response. This parameter is used to
/// calculate the difference in days between the provided date and the current date.
///
/// Returns:
///   The `FieldView` widget is being returned. This widget is a `StatefulWidget` that displays
/// information about a field, including its name, area, crop name, growth progress, days until harvest,
/// timeline information (planting date and expected harvest date), and a description. The widget makes
/// use of various UI components like `Container`, `Row`, `Column`, `Text`, `IconButton`,
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/edit_field.dart';
import 'package:grd_proj/screens/widget/border.dart';
import 'package:grd_proj/screens/widget/calculate_days.dart';
import 'package:grd_proj/screens/widget/circule_indector.dart';
import 'package:grd_proj/screens/widget/text.dart';
import 'package:intl/intl.dart';

class FieldView extends StatefulWidget {
  final String farmId;
  final String fieldId;
  const FieldView({super.key, required this.farmId, required this.fieldId});

  @override
  State<FieldView> createState() => _FieldViewState();
}



class _FieldViewState extends State<FieldView> {
  FieldBloc? _fieldBloc;
  int? selectedCropType;

  @override
  void initState() {
    _fieldBloc = context.read<FieldBloc>();
    _fieldBloc!
        .add(ViewFieldDetails(farmId: widget.farmId, fieldId: widget.fieldId));
    super.initState();
  }

  @override
  void dispose() {
    _fieldBloc!.add(OpenFieldEvent(farmId: widget.farmId));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<FieldBloc, FieldState>(
        listener: (context, state) {
          if (state is DeleteFieldFailure) {
            _fieldBloc!.add(ViewFieldDetails(
                farmId: widget.farmId, fieldId: widget.fieldId));
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMessage),
                ),
              );
            });
          } else if (state is DeleteFieldSuccess) {
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Field deleted successfully"),
                ),
              );
            });
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is FieldFailure) {
            return const Center(
              child: Text('Sorry Something went wrong',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  )),
            );
          }
          if (state is FieldSuccess) {
            return SafeArea(
                child: Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: grayColor2,
                              size: 24,
                            )),
                        Text(state.field.name,
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            )),
                        const Spacer(),
                        buildTag(
                          state.field.isActive ? "Activr" : "Inactive",
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: 380,
                      height: 220,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/alert.png',
                                color: primaryColor,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(width: 5),
                              text(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  label: "Field Information"),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          text(
                              color: grayColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              label: "Area"),
                          text(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              label: "${state.field.area.toString()} acres"),
                          const SizedBox(
                            height: 12,
                          ),
                          text(
                              color: grayColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              label: "Crop Name"),
                          text(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              label: state.field.cropName ?? "Not Exist"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: 380,
                      height: 230,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/prime_wave-pulse.png',
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 5),
                              text(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  label: "Progress & Status"),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          text(
                              color: grayColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              label: "Growth Progress"),
                          const SizedBox(
                            height: 5,
                          ),
                          text(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              label: state.field.progress == null
                                  ? "No Information"
                                  : "${state.field.progress.toString()}%"),
                          state.field.progress == null
                              ? const SizedBox(
                                  height: 1,
                                )
                              : LinearProgressIndicator(
                                  value: (state.field.progress! / 100),
                                  backgroundColor: Colors.grey[300],
                                  color: Colors.green[900],
                                  minHeight: 6,
                                ),
                          const SizedBox(
                            height: 12,
                          ),
                          text(
                              color: grayColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              label: "Days Until Harvest"),
                          text(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              label: state.field.expectedHarvestDate == null
                                  ? "No Information"
                                  : calculateDaysDifference(
                                          state.field.expectedHarvestDate!)
                                      .toString()),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: 380,
                      height: 230,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/calender.png',
                                color: primaryColor,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(width: 5),
                              text(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  label: "Timeline"),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          text(
                              color: grayColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              label: "Planting Date"),
                          const SizedBox(
                            height: 5,
                          ),
                          text(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              label: state.field.plantingDate == null
                                  ? "No Information"
                                  : DateFormat('MMM dd, yyyy')
                                      .format(state.field.plantingDate!)),
                          const SizedBox(
                            height: 12,
                          ),
                          text(
                              color: grayColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              label: "Expected Harvest Date"),
                          text(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              label: state.field.expectedHarvestDate == null
                                  ? "No Information"
                                  : DateFormat('MMM dd, yyyy')
                                      .format(state.field.expectedHarvestDate!))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: 380,
                      height: 180,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/Vector (1).png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(width: 5),
                              text(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  label: "Description"),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          text(
                              color: grayColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              label: state.field.description == null
                                  ? "Not Exist"
                                  : state.field.description!),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              _fieldBloc!.add(DeleteFieldEvent(
                                  farmId: state.field.farmId,
                                  fieldId: state.field.id));
                            },
                            child: Container(
                              width: 170,
                              height: 45,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(0, 255, 255, 255),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 255, 0, 0),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/delete.png',
                                      height: 20,
                                      width: 20,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "Delete Field",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontFamily: "Manrope",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditField(
                                        farmId: state.field.farmId,
                                        fieldId: state.field.id,
                                      )),
                            );
                          },
                          child: Container(
                            width: 99,
                            height: 45,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF616161),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/edit.png',
                                    height: 20,
                                    width: 20,
                                    color: whiteColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w600,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24,),
                  ],
                ),
              ),
            ));
          }
          return circularProgressIndicator();
        },
      ),
    );
  }
}
