// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/diseaseDetections.dart';
import 'package:grd_proj/screens/widget/disease_detection.dart';
import 'package:grd_proj/screens/widget/text.dart';
import 'package:intl/intl.dart';

class DiseaseDetectionShowImage extends StatefulWidget {
  final DiseaseDetectionModel info;
  const DiseaseDetectionShowImage({
    super.key,
    required this.info,
  });

  @override
  State<DiseaseDetectionShowImage> createState() =>
      _DiseaseDetectionShowImageState();
}

class _DiseaseDetectionShowImageState extends State<DiseaseDetectionShowImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Detection From ${DateFormat('d MMM, yyyy').format(widget.info.createdOn)}",
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
                    widget.info.healthStatus == 0
                        ? 'assets/images/mark.png'
                        : widget.info.healthStatus == 1
                            ? 'assets/images/alert.png'
                            : 'assets/images/iconoir_delete-circle.png',
                    color: getHealthLevelColor(widget.info.healthStatus),
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 8),
                  widget.info.isHealthy
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
                                  text: widget.info.diseaseName,
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
                      color: getHealthLevelColor(widget.info.healthStatus)!,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: text(
                          fontSize: 16,
                          label: getHealthLevelLabel(widget.info.healthStatus)!,
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
                            .format(widget.info.createdOn),
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
                            "Confidence level:${(widget.info.confidenceLevel * 100).toStringAsFixed(2)}%",
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
                      label: widget.info.createdBy,
                      color: grayColor),
                ]),
                SizedBox(height: 45),
                Center(
                  child: SizedBox(
                    height: 260,
                    width: 400,
                    child: Image.network(
                      widget.info.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: widget.info.isHealthy ? 150 : 190,
                    width: 400,
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
                          widget.info.isHealthy
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
                          !widget.info.isHealthy
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
                                          text:
                                              widget.info.treatments.toString(),
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
          )),
    );
  }
}
