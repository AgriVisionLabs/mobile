import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/diseaseDetections.dart';
import 'package:grd_proj/screens/disease_detection_screen.dart';
import 'package:grd_proj/screens/disease_detection_show_image.dart';
import 'package:grd_proj/screens/widget/circule_indector.dart';
import 'package:grd_proj/screens/widget/disease_detection.dart';
import 'package:grd_proj/screens/widget/text.dart';
import 'package:intl/intl.dart';

class FieldDiseaseDetection extends StatefulWidget {
  const FieldDiseaseDetection({
    super.key,
  });

  @override
  State<FieldDiseaseDetection> createState() => _FieldDiseaseDetectionState();
}

class _FieldDiseaseDetectionState extends State<FieldDiseaseDetection> {
  ControlBloc? _controlBloc;
  int selectedTab = 0;
  DateTime? lastScan;
  String? byWho;
  final List<String> tabs = [
    "All Fields",
    "Healthy",
    "Risk",
    "Infeacted",
  ];
  @override
  void initState() {
    _controlBloc = context.read<ControlBloc>();
    _controlBloc!.add(OpenFieldDiseaseDetectionEvent(
        farmId: _controlBloc!.farmId.text, fieldId:  _controlBloc!.fieldId.text));
    super.initState();
  }

  double risk = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ControlBloc, ControlState>(
        builder: (context, state) {
          if (state is ViewDetectionsSuccess) {
            risk = getrisk(state.info)!;
            lastScan = state.info.last.createdOn;
            byWho = state.info.last.createdBy;
            return Container(
              margin: const EdgeInsets.fromLTRB(16, 150, 16, 1),
              height: double.infinity,
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            text(
                                fontSize: 24,
                                label:  _controlBloc!.farmName.text,
                                fontWeight: FontWeight.bold),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.grey[600],
                                size: 24,
                              ),
                            )
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
                                label:  _controlBloc!.cropName.text,
                                color: textColor2)
                          ],
                        ),
                        Container(
                            width: 380,
                            height: 342,
                            margin: const EdgeInsets.only(
                                top: 24, bottom: 24, left: 10, right: 10),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: const Color.fromARGB(30, 13, 18, 28),
                                    width: 1),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(60, 0, 0, 0),
                                      blurRadius: 15,
                                      spreadRadius: 0.6,
                                      offset: Offset(0, 2.25))
                                ]),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(
                                      fontSize: 22,
                                      label: "Field Overview",
                                      fontWeight: FontWeight.w600),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      text(fontSize: 20, label: "Crop Health"),
                                      const Spacer(),
                                      text(
                                          fontSize: 20,
                                          label: "${risk.toInt()} %"),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 400,
                                    height: 10,
                                    child: LinearProgressIndicator(
                                      value: risk / 100,
                                      backgroundColor:
                                          const Color.fromARGB(63, 97, 97, 97),
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
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
                                          label:
                                              "Last Inspection: ${DateFormat('d MMM, yyyy').format(lastScan!)}",
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
                                      text(
                                          fontSize: 18,
                                          label: "By: $byWho",
                                          color: grayColor2)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/images/oui_app-lens.png',
                                        color: grayColor,
                                        height: 24,
                                        width: 24,
                                      ),
                                      const SizedBox(width: 5),
                                      text(
                                          fontSize: 18,
                                          label:
                                              "Total Detection: ${state.info.length}",
                                          color: grayColor2)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/images/mark.png',
                                        height: 24,
                                        width: 24,
                                      ),
                                      const SizedBox(width: 5),
                                      text(
                                          fontSize: 18,
                                          label:
                                              "Current Status: ${getHealthLevelLabel(getlevl(risk))!}",
                                          color: grayColor2)
                                    ],
                                  ),
                                ])),
                        Container(
                          width: 380,
                          height: 240,
                          margin: const EdgeInsets.only(
                              top: 24, bottom: 24, left: 10, right: 10),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                  color: const Color.fromARGB(30, 13, 18, 28),
                                  width: 1),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(60, 0, 0, 0),
                                    blurRadius: 15,
                                    spreadRadius: 0.7,
                                    offset: Offset(0, 2.25))
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text(
                                    fontSize: 22,
                                    label: "Actions",
                                    fontWeight: FontWeight.w600),
                                const SizedBox(height: 30),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiseaseDetectionScreen(
                                                    farmName:  _controlBloc!.farmName.text,
                                                    cropName:  _controlBloc!.cropName.text,
                                                    farmId:  _controlBloc!.farmId.text,
                                                    fieldId:  _controlBloc!.fieldId.text,
                                                  )));
                                    },
                                    child: Container(
                                      width: 380,
                                      height: 54,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(45),
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
                                                fontWeight: FontWeight.w500,
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
                                  height: 16,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 380,
                                      height: 54,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            0, 30, 105, 48),
                                        borderRadius: BorderRadius.circular(45),
                                        border: Border.all(
                                          color: primaryColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/lucide_leaf.png',
                                              color: primaryColor,
                                              height: 23,
                                              width: 23,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Text(
                                              "Manage Field",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Manrope",
                                                fontWeight: FontWeight.w500,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 20),
                        text(
                            fontSize: 22,
                            label: "Detection History",
                            fontWeight: FontWeight.w600),
                        const SizedBox(height: 20),
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
                                    padding: const EdgeInsets.only(right: 11),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  if (selectedTab == 0)
                    _buildScreen(state.info)
                  else if (selectedTab == 1)
                    _buildScreen(
                        state.info.where((i) => i.healthStatus == 0).toList())
                  else if (selectedTab == 2)
                    _buildScreen(
                        state.info.where((i) => i.healthStatus == 1).toList())
                  else if (selectedTab == 3)
                    _buildScreen(
                        state.info.where((i) => i.healthStatus == 2).toList())
                ],
              ),
            );
          } else if (state is ViewDiseaseDetectionsFailure) {
            return Center(
              child: text(fontSize: 24, label: "Failed to load data"),
            );
          } else if (state is DiseaseDetectionEmpty) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: text(fontSize: 24, label: "Nothing found"),
                  ),
                ),
              ],
            );
          }
          return circularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildScreen(List<DiseaseDetectionModel> info) {
    if (info.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
            height: 200,
            width: 400,
            child: Center(
              child: text(fontSize: 22, label: "No Avaliable Data"),
            )),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: info.length,
        (context, index) {
          final item = info[index];
          return Container(
              margin: const EdgeInsets.only(
                  top: 24, bottom: 24, left: 10, right: 10),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: const Color.fromARGB(30, 13, 18, 28), width: 1),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(60, 0, 0, 0),
                        blurRadius: 15,
                        spreadRadius: 0.7,
                        offset: Offset(0, 2.25))
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              item.healthStatus == 0
                                  ? 'assets/images/mark.png'
                                  : item.healthStatus == 1
                                      ? 'assets/images/alert.png'
                                      : 'assets/images/iconoir_delete-circle.png',
                              color: getHealthLevelColor(item.healthStatus),
                              height: 23,
                              width: 23,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(getHealthLevelLabel(item.healthStatus)!,
                                style: const TextStyle(
                                  color: testColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "manrope",
                                )),
                          ],
                        ),
                        const SizedBox(height: 16),
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
                                label:
                                    "Last Inspection: ${DateFormat('d MMM, yyyy').format(lastScan!)}",
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
                            text(
                                fontSize: 18,
                                label: "By: $byWho",
                                color: grayColor2)
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/mynaui_image.png',
                              color: grayColor,
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(width: 5),
                            text(
                                fontSize: 18,
                                label: item.imageUrl.isNotEmpty
                                    ? "Image Available"
                                    : "Image Not Available",
                                color: grayColor2)
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DiseaseDetectionShowImage(
                                            scanId: item.id,
                                            farmId: item.farmId,
                                          )));
                            },
                            child: Container(
                              width: 380,
                              height: 54,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(45),
                                border: Border.all(
                                  color: borderColor,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/eye.png',
                                      color: bottomBarColor,
                                      height: 23,
                                      width: 23,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      "Show Image",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Manrope",
                                        fontWeight: FontWeight.w500,
                                        color: bottomBarColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]));
        },
      ),
    );
  }
}
