import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/diseaseDetections.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/screens/disease_detection_screen.dart';
import 'package:grd_proj/screens/home_screen.dart';
import 'package:grd_proj/screens/widget/disease_detection.dart';
import 'package:grd_proj/screens/widget/text.dart';
import 'package:intl/intl.dart';

class BuildDetecions extends StatefulWidget {
  final String farmName;
  final String farmId;
  final int? status;
  final List<FieldModel> fields;
  const BuildDetecions(
      {super.key,
      required this.farmId,
      this.status,
      required this.fields,
      required this.farmName});

  @override
  State<BuildDetecions> createState() => _BuildDetecionsState();
}

class _BuildDetecionsState extends State<BuildDetecions> {
  List<DiseaseDetectionModel>? info;
  ControlBloc? _controlBloc;
  List<String> loadingFieldsIds = [];
  List<FieldModel>? pendingFieldIdByState = [];
  DateTime? lastScan;
  double totalProgress = 0;
  double risk = 0;
  int? healthStatus;
  @override
  void initState() {
    _controlBloc = context.read<ControlBloc>();
    _controlBloc!.add(OpenFarmDiseaseDetectionEvent(farmId: widget.farmId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ControlBloc, ControlState>(
      listener: (context, state) {
        if (state is ViewDetectionsSuccess) {
          setState(() {
            info = state.info;
          });
        } else if (state is DiseaseDetectionEmpty) {
          info = [];
        } else if (state is ViewDiseaseDetectionsFailure) {
          info = [];
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to load detections")),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 520,
          width: 400,
          child: widget.fields.isEmpty
              ? const Center(
                  child: Text('Nothing Found',
                      style: TextStyle(
                        color: Color(0xff1E6930),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "manrope",
                      )),
                )
              : CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: widget.fields.length,
                        (context, index) {
                          final item = widget.fields[index];

                          final detections = info
                                  ?.where((i) => i.fieldId == item.id)
                                  .toList() ??
                              [];
                          if (item.cropName == null) {
                            return const SizedBox.shrink();
                          }

                          risk = getrisk(detections)!;
                          return GestureDetector(
                            onTap: () {
                              _controlBloc!.farmName.text = widget.farmName;
                              _controlBloc!.fieldId.text = item.id;
                              _controlBloc!.fieldName.text = item.name;
                              _controlBloc!.farmId.text = item.farmId;
                              _controlBloc!.cropName.text = item.cropName!;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                           const HomeScreen(initialIndex:10 ,)));
                            },
                            child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 20, left: 5, right: 5, top: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            62, 13, 18, 28),
                                        width: 1),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromARGB(50, 0, 0, 0),
                                          blurRadius: 15,
                                          spreadRadius: 2,
                                          offset: Offset(0, 5))
                                    ]),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 24),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                text(
                                                    fontSize: 24,
                                                    label: item.name,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                const Spacer(),
                                                Container(
                                                  width: 77,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: detections.isEmpty
                                                        ? borderColor
                                                        : getHealthLevelColor(
                                                            getlevl(risk)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: Center(
                                                    child: text(
                                                        fontSize: 16,
                                                        label: detections
                                                                .isEmpty
                                                            ? "No Info"
                                                            : getHealthLevelLabel(
                                                                getlevl(risk))!,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: bottomBarColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/lucide_leaf.png',
                                                  height: 24,
                                                  width: 24,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                text(
                                                    fontSize: 20,
                                                    label: item.cropName ??
                                                        "Not Exist",
                                                    color: textColor2)
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            if (detections.isEmpty)
                                              text(
                                                  fontSize: 24,
                                                  label: "No Detections")
                                            else
                                              _buildInfo(info: detections),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: grayColor,
                                        thickness: 1,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DiseaseDetectionScreen(
                                                          farmName:
                                                              widget.farmName,
                                                          cropName:
                                                              item.cropName!,
                                                          farmId: widget.farmId,
                                                          fieldId: item.id,
                                                        )));
                                          },
                                          child: Container(
                                            width: 224,
                                            height: 54,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              border: Border.all(
                                                color: const Color(0xFF616161),
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/tabler_camera.png',
                                                    height: 23,
                                                    width: 23,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  const Text(
                                                    "New Detection",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "Manrope",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      )
                                    ])),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildInfo({required List<DiseaseDetectionModel> info}) {
    final DateTime lastScan = info.last.createdOn;
    final String byWho = info.last.createdBy;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            text(fontSize: 20, label: "Crop Health"),
            const Spacer(),
            text(fontSize: 20, label: "${risk.toInt()} %"),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 400,
          height: 10,
          child: LinearProgressIndicator(
            value: risk / 100,
            backgroundColor: const Color.fromARGB(63, 97, 97, 97),
            color: primaryColor,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        const SizedBox(height: 16),
        text(fontSize: 20, label: "Recent Detections"),
        const SizedBox(height: 10),
        info.isEmpty
            ? text(fontSize: 24, label: "No Detections")
            : ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: info.length.clamp(0, 3),
                itemBuilder: (context, index) {
                  final disease = info[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(children: [
                      Image.asset(
                        disease.healthStatus == 0
                            ? 'assets/images/mark.png'
                            : disease.healthStatus == 1
                                ? 'assets/images/alert.png'
                                : 'assets/images/iconoir_delete-circle.png',
                        color: getHealthLevelColor(disease.healthStatus),
                        height: 23,
                        width: 23,
                      ),
                      const SizedBox(width: 5),
                      text(
                          fontSize: 18,
                          label: DateFormat('d MMM, yyyy')
                              .format(disease.createdOn)),
                      const Spacer(),
                      Container(
                        width: 77,
                        height: 30,
                        decoration: BoxDecoration(
                          color: getHealthLevelColor(disease.healthStatus),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: text(
                              fontSize: 16,
                              label: getHealthLevelLabel(disease.healthStatus)!,
                              fontWeight: FontWeight.w600,
                              color: bottomBarColor),
                        ),
                      ),
                    ]),
                  );
                },
              ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          thickness: 1,
          color: grayColor,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/calender.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 5),
            text(
                fontSize: 18,
                label: "Last: ${DateFormat('dd MMM, yyyy').format(lastScan)}",
                color: grayColor)
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/person_icon.png',
              color: grayColor,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 5),
            text(fontSize: 18, label: "By: $byWho", color: grayColor2)
          ],
        ),
      ],
    );
  }
}
