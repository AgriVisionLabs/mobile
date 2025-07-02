import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/widget/border.dart';
import 'package:grd_proj/screens/widget/circule_indector.dart';
import 'package:grd_proj/screens/widget/text.dart';

class FieldView extends StatefulWidget {
  const FieldView({super.key});

  @override
  State<FieldView> createState() => _FieldViewState();
}

class _FieldViewState extends State<FieldView> {
  FieldBloc? _fieldBloc;
  int? selectedCropType;
  final today = DateTime(2025, 6, 27);
  final targetDate = DateTime(2025, 11, 26);

  @override
  void initState() {
    _fieldBloc = context.read<FieldBloc>();
    _fieldBloc!.add(ViewFieldDetails(
        farmId: '552fc0cc-4937-49d7-9807-2f80ff22290a',
        fieldId: 'd38d0893-f7c9-40a6-a9d6-183d103d163d'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final difference = targetDate.difference(today).inDays;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FieldBloc, FieldState>(
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
              margin: const EdgeInsets.fromLTRB(20, 100, 20, 5),
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
                        color: containerColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/alert.png',
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
                        color: containerColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/alert.png',
                              height: 20,
                              width: 20,
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
                                ? "Not Exist"
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
                                ? "Not Information"
                                : difference.toString()),
                      ],
                    ),
                  )
                ],
              ),
            ));
          }
          return circularProgressIndicator();
        },
      ),
    );
  }
}
