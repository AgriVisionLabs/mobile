// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'field_bloc.dart';

@immutable
abstract class FieldEvent {}

class OpenFieldEvent extends FieldEvent {
  final String farmId;
  final String? farmname;
  final String? roleName;
  final int? size;
  final String? location;
  final int? soiltype;
  OpenFieldEvent({
    required this.farmId,
    this.farmname,
    this.roleName,
    this.size,
    this.location,
    this.soiltype,
  });
  
  
}

class CreateFieldEvent extends FieldEvent{}

class DeleteFieldEvent extends FieldEvent {
  final String farmId;
  final String fieldId;
  DeleteFieldEvent({
    required this.farmId,
    required this.fieldId,
  });
}

class EditFieldEvent extends FieldEvent{}

class ViewFieldDetails extends FieldEvent {
  final String farmId;
  final String fieldId;
  ViewFieldDetails({
    required this.farmId,
    required this.fieldId,
  });
  
}

class AddIrrigationUnitEvent extends FieldEvent {
  final String fieldId;
  final String farmId;
  AddIrrigationUnitEvent({
    required this.fieldId,
    required this.farmId,
  });
}

class OpenFarmIrrigationUnitsEvent extends FieldEvent {
  final String farmId;
  OpenFarmIrrigationUnitsEvent({
    required this.farmId,
  });
}

class OpenFieldIrrigationUnitsEvent extends FieldEvent {
  final String fieldId;
  final String farmId;
  OpenFieldIrrigationUnitsEvent({
    required this.fieldId,
    required this.farmId,
  });
}

class IrrigationUnitsEditEvent extends FieldEvent {
  final String fieldId;
  final String farmId;
  final String name;
  final String newFieldId;
  final int status;
  IrrigationUnitsEditEvent({
    required this.fieldId,
    required this.farmId,
    required this.name,
    required this.newFieldId,
    required this.status,
  });
  
}

class DeleteIrrigationUnitEvent extends FieldEvent {
  final String farmId;
  final String fieldId;
  DeleteIrrigationUnitEvent({
    required this.farmId,
    required this.fieldId,
  });
  
}


class AddSensorUnitEvent extends FieldEvent {
  final String fieldId;
  final String farmId;
  AddSensorUnitEvent({
    required this.fieldId,
    required this.farmId,
  });
  
}

class OpenFarmSensorUnitsEvent extends FieldEvent {
  final String farmId;
  OpenFarmSensorUnitsEvent({
    required this.farmId,
  });
}

class OpenFieldSensorUnitsEvent extends FieldEvent {
  final String fieldId;
  final String farmId;
  final String sensorId;
  OpenFieldSensorUnitsEvent({
    required this.fieldId,
    required this.farmId,
    required this.sensorId,
  });
}

class SensorUnitEditEvent extends FieldEvent {
  final String fieldId;
  final String farmId;
  final String name;
  final String newFieldId;
  final int status;
  final String sensorId;
  SensorUnitEditEvent({
    required this.fieldId,
    required this.farmId,
    required this.name,
    required this.newFieldId,
    required this.status,
    required this.sensorId,
  });
  
}

class DeleteSensorUnitEvent extends FieldEvent {
  final String farmId;
  final String fieldId;
  final String sensorId;
  DeleteSensorUnitEvent({
    required this.farmId,
    required this.fieldId,
    required this.sensorId,
  });
  
}

