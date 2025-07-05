import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/diseaseDetections.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/screens/widget/circule_indector.dart';
import 'package:grd_proj/screens/widget/disease_detection.dart';
import 'package:grd_proj/screens/widget/text.dart';

class BuildDetecions extends StatefulWidget {
  final String farmId;
  final int? status;
  final List<FieldModel> fields;
  const BuildDetecions(
      {super.key, required this.farmId, this.status, required this.fields});

  @override
  State<BuildDetecions> createState() => _BuildDetecionsState();
}

class _BuildDetecionsState extends State<BuildDetecions> {
  List<DiseaseDetectionModel>? info;
  ControlBloc? _controlBloc;
  @override
  void initState() {
    _controlBloc = context.read<ControlBloc>();
    _controlBloc!.add(OpenDiseaseDetectionEvent(farmId: widget.farmId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlBloc, ControlState>(
      builder: (context, state) {
        if (state is ViewDiseaseDetectionFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        } else if (state is ViewDetectionSuccess) {
          info = getList(state.info, widget.status);
          return Container(
            height: 500,
            width: 400,
            child: info!.isEmpty
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
                            return Container(
                                margin: const EdgeInsets.only(
                                    bottom: 40, left: 10, right: 10),
                                padding: const EdgeInsets.all(24),
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
                                      Row(
                                        children: [
                                          text(
                                              fontSize: 22,
                                              label: item.name,
                                              fontWeight: FontWeight.w600),
                                          const Spacer(),
                                          // Container(
                                          //   width: 77,
                                          //   height: 30,
                                          //   decoration: BoxDecoration(
                                          //     color: getHealthLevelColor(
                                          //         item.healthStatus),
                                          //     borderRadius:
                                          //         BorderRadius.circular(25),
                                          //   ),
                                          //   child: Center(
                                          //     child: text(
                                          //         fontSize: 16,
                                          //         label: getHealthLevelLabel(
                                          //             item.healthStatus)!,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: bottomBarColor),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/lucide_leaf.png',
                                          ),
                                          SizedBox(width: 5,),
                                          text(fontSize: 20, label: "label", color: textColor2)
                                        ],
                                      ),
                                      ListView.builder(
                                        itemBuilder: (context, index) {
                                          if (index == 0) {
                                            return Container(
                                              child: Column(children: [
                                                Row(
                                                  children: [
                                                    text(fontSize: 20 , label: "Crop Health"),
                                                    Spacer(),
                                                    text(fontSize: 20, label: "66"),
                                                  ],
                                                ),
                                              ]),
                                            );
                                          } else {
                                            return Container(
                                              child: Row(
                                                children: [
                                                  text(fontSize: 20, label: "Crop Health"),
                                                  Spacer(),
                                                  text(fontSize: 20, label: info![index].createdOn.toString()),
                                                ]
                                              )
                                            );
                                          }
                                        },
                                      ),
                                    ]));
                          },
                        ),
                      ),
                    ],
                  ),
          );
        } else if (state is DiseaseDetectionEmpty) {
          return const SizedBox(
              child: Center(
                  child: Text('No Scans found',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontFamily: "manrope",
                        color: primaryColor,
                      ))));
        }
        return circularProgressIndicator();
      },
    );
  }
}
