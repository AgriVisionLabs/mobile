// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/widget/circule_indector.dart';
import 'package:grd_proj/screens/widget/disease_detection.dart';
import 'package:grd_proj/screens/widget/text.dart';
import 'package:intl/intl.dart';

class DiseaseDetectedScreen extends StatefulWidget {
  final String farmId;
  const DiseaseDetectedScreen({
    super.key,
    required this.farmId,
  });

  @override
  State<DiseaseDetectedScreen> createState() => _DiseaseDetectedScreenState();
}

class _DiseaseDetectedScreenState extends State<DiseaseDetectedScreen> {
  ControlBloc? _controlBloc;

  @override
  void initState() {
    _controlBloc = context.read<ControlBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _controlBloc!.add(OpenFarmDiseaseDetectionEvent(farmId: widget.farmId));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
        child: BlocBuilder<ControlBloc, ControlState>(
          builder: (context, state) {
            if (state is DiseaseScanSuccess) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Detection From ${DateFormat('d MMM, yyyy').format(state.info.createdOn)}",
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
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
                    SizedBox(height: 24),
                    Divider(
                      color: borderColor,
                      thickness: 1,
                    ),
                    SizedBox(height: 24),
                    Row(children: [
                      Image.asset(
                        state.info.healthStatus == 0?
                             'assets/images/mark.png' :state.info.healthStatus == 1?'assets/images/alert.png'
                            : 'assets/images/iconoir_delete-circle.png',
                        color: getHealthLevelColor(state.info.healthStatus),
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      state.info.isHealthy
                          ? text(
                              fontSize: 20,
                              label: "Healthy",
                              fontWeight: FontWeight.w600)
                          : Expanded(
                              flex: 3,
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: state.info.diseaseName,
                                      style: const TextStyle(
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      const Spacer(),
                      Container(
                        width: 77,
                        height: 30,
                        decoration: BoxDecoration(
                          color: getHealthLevelColor(state.info.healthStatus)!,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: text(
                              fontSize: 16,
                              label:
                                  getHealthLevelLabel(state.info.healthStatus)!,
                              fontWeight: FontWeight.w600,
                              color: bottomBarColor),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 24,
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
                            fontSize: 20,
                            label: DateFormat('d MMM, yyyy')
                                .format(state.info.createdOn),
                            color: grayColor),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/mark.png',
                          color: grayColor,
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 5),
                        text(
                            fontSize: 20,
                            label:
                                "Confidence level:${(state.info.confidenceLevel * 100).toStringAsFixed(2)}%",
                            color: grayColor),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image.asset(
                        'assets/images/person_icon.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 5),
                      text(
                          fontSize: 20,
                          label: state.info.createdBy,
                          color: grayColor),
                    ]),
                    SizedBox(height: 45),
                    Center(
                      child: SizedBox(
                        height: 260,
                        width: 360,
                        child: Image.network(
                          state.info.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Spacer(),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        height: state.info.isHealthy ? 150 : 190,
                        width: 380,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(63, 159, 159, 159),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(
                                  fontSize: 20,
                                  label: "Analysis result",
                                  fontWeight: FontWeight.w600),
                              SizedBox(
                                height: 16,
                              ),
                              state.info.isHealthy
                                  ? text(
                                      fontSize: 18,
                                      label:
                                          "No disease detected. the crop appears healthy.")
                                  : text(
                                      fontSize: 18,
                                      label:
                                          "Disease detected. the crop appears infected"),
                              SizedBox(
                                height: 16,
                              ),
                              !state.info.isHealthy
                                  ? Expanded(
                                      flex: 3,
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Manrope',
                                              fontWeight: FontWeight.w600),
                                          children: [
                                            TextSpan(
                                              text: "Treatments : ",
                                              style: const TextStyle(
                                                  color: testColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            TextSpan(
                                              text: state.info.treatments
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: primaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 1,
                                    )
                            ]),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              );
            }else if(state is DiseaseScanLoading){
              text(fontSize: 22, label: "Loading..........");
            }
            return circularProgressIndicator();
          },
        ),
      ),
    );
  }
}
