// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'control_bloc.dart';

@immutable
abstract class ControlEvent {}

class AddAutomationRulesEvent extends ControlEvent {
  final String fieldId;
  final String farmId;
  AddAutomationRulesEvent({
    required this.fieldId,
    required this.farmId,
  });
}

class OpenFarmAutomationRulesEvent extends ControlEvent {
  final String farmId;
  OpenFarmAutomationRulesEvent({
    required this.farmId,
  });
}

class OpenFieldAutomationRulesEvent extends ControlEvent {
  final String fieldId;
  final String farmId;
  final String ruleId;
  OpenFieldAutomationRulesEvent({
    required this.fieldId,
    required this.farmId,
    required this.ruleId,
  });
}

class AutomationRulesEditEvent extends ControlEvent {
  final String fieldId;
  final String farmId;
  final String ruleId;
  final String name;
  final bool isEnabled; 
  final int type;
  final double? max;
  final double? min;
  final int? target;
  final String? start;
  final String? end;
  final int? days;
  AutomationRulesEditEvent({
    required this.fieldId,
    required this.farmId,
    required this.ruleId,
    required this.name,
    required this.isEnabled,
    required this.type,
    this.max,
    this.min,
    this.target,
    this.start,
    this.end,
    this.days,
  });
  
  
  
}

class DeleteAutomationRulesEvent extends ControlEvent {
  final String farmId;
  final String fieldId;
  final String ruleId;
  DeleteAutomationRulesEvent({
    required this.farmId,
    required this.fieldId,
    required this.ruleId,
  });
  
}


