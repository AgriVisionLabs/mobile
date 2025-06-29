import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/automation_rule_model.dart';
import 'package:grd_proj/screens/automation_rule_edit.dart';

class AutomationRules extends StatefulWidget {
  final String farmName;
  final String farmId;
  final String? fieldId;
  final String? statue;
  final String? type;
  const AutomationRules(
      {super.key,
      required this.farmName,
      required this.farmId,
      this.fieldId,
      this.statue,
      this.type});

  @override
  State<AutomationRules> createState() => AutomationRulesState();
}

class AutomationRulesState extends State<AutomationRules> {
  String description = '';
  @override
  void initState() {
    context
        .read<ControlBloc>()
        .add(OpenFarmAutomationRulesEvent(farmId: widget.farmId));
    super.initState();
  }

  void reloadData() {
    context.read<ControlBloc>().add(
          OpenFarmAutomationRulesEvent(farmId: widget.farmId),
        );
  }

  bool? _status;
  int? _type;
  List<AutomationRuleModel>? rules;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlBloc, ControlState>(
      builder: (context, state) {
        if (state is ViewAutomationRulesFailure) {
          if (state.errMessage == "Not Found") {
            description = state.errors[0]['description'];
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(description),
                ),
              );
            });
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMessage),
                ),
              );
            });
          }
        } else if (state is ViewAutomationRulesSuccess) {
          if (widget.fieldId != null &&
              widget.statue != null &&
              widget.type != null) {
            if (widget.fieldId!.isNotEmpty) {
              rules = state.rules
                  .where((device) => device.fieldId == widget.fieldId)
                  .toList();
            }
            if (widget.type!.isNotEmpty) {
              widget.type == 'threshold' ? _type = 0 : _type = 1;
              rules = state.rules.where((rule) => rule.type == _type).toList();
            }
            if (widget.statue!.isNotEmpty) {
              widget.statue == 'active' ? _status = true : _status = false;
              rules = state.rules
                  .where((rule) => rule.isEnabled == _status)
                  .toList();
            }
          } else {
            rules = state.rules;
          }
          return SizedBox(
            height: rules!.isEmpty
                ? 100
                : rules!.length == 1
                    ? 300
                    : 520,
            child: rules!.isEmpty
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
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: rules!.length,
                          (context, index) {
                            final item = rules![index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.only(top: 24),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color:
                                          const Color.fromARGB(62, 13, 18, 28),
                                      width: 1),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromARGB(50, 0, 0, 0),
                                        blurRadius: 15,
                                        spreadRadius: 0.7,
                                        offset: Offset(0, 2.25))
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item.name,
                                              style: const TextStyle(
                                                color: Color(0xff1E6930),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "manrope",
                                              )),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/alert.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                  item.type == 1
                                                      ? "Type : Schedualed"
                                                      : "Type : Threshold",
                                                  style: const TextStyle(
                                                    color: Color(0xff616161),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "manrope",
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/location.png',
                                                width: 24,
                                                height: 24,
                                              ),
                                              const SizedBox(width: 8),
                                              Text("Field : ${item.fieldName}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF616161),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "manrope",
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/Performance_indicators.png',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                      item.type == 0
                                                          ? "Threshold : ${item.minThresholdValue} - ${item.maxThresholdValue} "
                                                          : "Schedualed : ${item.startTime} - ${item.endTime}",
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xff0D121C),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "manrope",
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 24),
                                        ],
                                      )),
                                  const Divider(
                                    color: Color.fromARGB(63, 13, 18, 28),
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Row(
                                      children: [
                                        Switch(
                                          value: item.isEnabled,
                                          onChanged: (value) {
                                            context
                                                .read<ControlBloc>()
                                                .add(AutomationRulesEditEvent(
                                                  fieldId: item.fieldId,
                                                  farmId: item.farmId,
                                                  ruleId: item.id,
                                                  name: item.name,
                                                  isEnabled: !item.isEnabled,
                                                  type: item.type,
                                                  min: item.minThresholdValue,
                                                  max: item.maxThresholdValue,
                                                  target: item.targetSensorType,
                                                  start: item.startTime,
                                                  end: item.endTime,
                                                  days: item.activeDays,
                                                ));
                                            context.read<ControlBloc>().add(
                                                OpenFarmAutomationRulesEvent(
                                                    farmId: item.farmId));
                                          },
                                          activeColor: Colors.white,
                                          activeTrackColor: primaryColor,
                                          inactiveTrackColor: Colors.grey[300],
                                          inactiveThumbColor: Colors.white,
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AutomationRuleEdit(
                                                        farmId: item.farmId,
                                                        fieldId: item.fieldId,
                                                        ruleId: item.id,
                                                      )),
                                            );
                                          },
                                          child: Image.asset(
                                              'assets/images/edit.png',
                                              width: 30,
                                              height: 30),
                                        ),
                                        const SizedBox(width: 20),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<ControlBloc>().add(
                                                DeleteAutomationRulesEvent(
                                                    farmId: item.farmId,
                                                    fieldId: item.fieldId,
                                                    ruleId: item.id));
                                            context.read<ControlBloc>().add(
                                                OpenFarmAutomationRulesEvent(
                                                    farmId: item.farmId));
                                          },
                                          child: Image.asset(
                                              'assets/images/delete.png',
                                              width: 30,
                                              height: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        } else if (state is AutomationRulesEmpty) {
          return DottedBorder(
            color: Colors.grey,
            strokeWidth: 1.5,
            borderType: BorderType.RRect,
            radius: const Radius.circular(15),
            dashPattern: const [6, 4],
            child: Container(
              width: 375,
              height: 240,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 60,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No Rules Found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: "manrope",
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "No automation rules found . Try adding a new rule or adjusting your filters.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: "manrope",
                      color: Color.fromARGB(166, 51, 51, 51),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox(
            child: Center(
                child: CircularProgressIndicator(
          color: primaryColor,
        )));
      },
    );
  }
}
