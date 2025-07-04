// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'field_bloc.dart';

@immutable
abstract class FieldEvent {}

class OpenFieldEvent extends FieldEvent {
  final String farmId;
  OpenFieldEvent({
    required this.farmId,
  });
  
  
}

class CreateFieldEvent extends FieldEvent {
  final String farmId;
  CreateFieldEvent({
    required this.farmId,
  });

}

class DeleteFieldEvent extends FieldEvent {
  final String farmId;
  final String fieldId;
  DeleteFieldEvent({
    required this.farmId,
    required this.fieldId,
  });
}

class EditFieldEvent extends FieldEvent{
  final String farmId;
  final String fieldId;

  EditFieldEvent({required this.farmId, required this.fieldId});
}

class ViewFieldDetails extends FieldEvent {
  final String farmId;
  final String fieldId;
  ViewFieldDetails({
    required this.farmId,
    required this.fieldId,
  });
  
}

class ViewCropTypes extends FieldEvent {}

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
  IrrigationUnitsEditEvent({
    required this.fieldId,
    required this.farmId,
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

class IrrigationUnitToggleEvent extends FieldEvent {
  final String farmId;
  final String fieldId;
  IrrigationUnitToggleEvent({
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
  final String sensorId;
  SensorUnitEditEvent({
    required this.fieldId,
    required this.farmId,
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

class UseDiseaseDetectionEvent extends FieldEvent {
  final String fieldId;
  final String farmId;
  UseDiseaseDetectionEvent({
    required this.fieldId,
    required this.farmId,
  });
  
}

class OpenDiseaseDetectionEvent extends FieldEvent {
  final String fieldId;
  final String farmId;
  OpenDiseaseDetectionEvent({
    required this.fieldId,
    required this.farmId,
  });
}

