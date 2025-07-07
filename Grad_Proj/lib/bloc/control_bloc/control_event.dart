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

class AddTaskEvent extends ControlEvent {
  final String farmId;
  final String fieldId;
  AddTaskEvent({
    required this.farmId,
    required this.fieldId,
  });
  
}

class OpenFarmTasksEvent extends ControlEvent {
  final String farmId;
  OpenFarmTasksEvent({
    required this.farmId,
  });
}

class OpenTaskEvent extends ControlEvent {
  final String farmId;
  final String taskId;
  OpenTaskEvent({
    required this.farmId,
    required this.taskId,
  });
}

class DeteteTaskEvent extends ControlEvent {
  final String farmId;
  final String taskId;
  DeteteTaskEvent({
    required this.farmId,
    required this.taskId,
  });
}

class CompleteTaskEvent extends ControlEvent {
  final String farmId;
  final String taskId;
  CompleteTaskEvent({
    required this.farmId,
    required this.taskId,
  });
}


class AddItemEvent extends ControlEvent {
  final String farmId;
  AddItemEvent({
    required this.farmId,
  });
  
}

class OpenFarmItemsEvent extends ControlEvent {
  final String farmId;
  OpenFarmItemsEvent({
    required this.farmId,
  });
}

class OpenItemEvent extends ControlEvent {
  final String farmId;
  final String itemId;
  OpenItemEvent({
    required this.farmId,
    required this.itemId,
  });
}

class DeleteItemEvent extends ControlEvent {
 final String farmId;
  final String itemId;
  DeleteItemEvent({
    required this.farmId,
    required this.itemId,
  });
}

class EditItemEvent extends ControlEvent {
  final String farmId;
  final String itemId;
  EditItemEvent({
    required this.farmId,
    required this.itemId,
  });
}

class AddLogEvent extends ControlEvent {
  final String farmId;
  final String itemId;
  AddLogEvent({
    required this.farmId,
    required this.itemId,
  });
}


class UseDiseaseDetectionEvent extends ControlEvent {
  final String farmId;
  final String fieldId;
  final File media;

  UseDiseaseDetectionEvent({
    required this.farmId,
    required this.fieldId,
    required this.media,
  });
}

class OpenFarmDiseaseDetectionEvent extends ControlEvent {
  final String farmId;
  OpenFarmDiseaseDetectionEvent({
    required this.farmId,
  });
}
class OpenFieldDiseaseDetectionEvent extends ControlEvent {
  final String farmId;
  final String fieldId;
  OpenFieldDiseaseDetectionEvent({
    required this.farmId,
    required this.fieldId
  });
}

class OpenDiseaseDetectionEvent extends ControlEvent {
  final String farmId;
  final String scanid;
  OpenDiseaseDetectionEvent({
    required this.farmId,
    required this.scanid,
  });
}
