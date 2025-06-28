// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'field_bloc.dart';

@immutable
abstract class FieldState {}

class FieldInitial extends FieldState {
  final List startlist;
  FieldInitial(this.startlist);
}
class FieldLoading extends FieldState {}
//رجعنا  ليست فعلا وهو كان عنده fields 
class FieldLoaded extends FieldState {
  final List<FieldModel> fields;
  FieldLoaded({
    required this.fields,
  });

}

//معندوش ولا field
class FieldEmpty extends FieldState {
  
}

final class FieldLoadingFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  
  FieldLoadingFailure({required this.errMessage,required this.errors});
}

//fields ظهرت
class FieldSuccess extends FieldState {
  final FieldModel field;
  FieldSuccess({
    required this.field,
  });
}

// دخلنا data و اتقبلت في basic info
class FieldInfoSuccess extends FieldState {}

//حصل مشكلة و احنا بنعرض ال fields
final class FieldFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  
  FieldFailure({required this.errMessage,required this.errors});
}

// دخلنا data متقبلتش في basic info
final class FieldInfoFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  
  FieldInfoFailure({required this.errMessage,required this.errors});
}

class DeleteFieldSuccess extends FieldState {}

final class DeleteFieldFailure extends FieldState {
  final String errMessage;
  final dynamic errors;

  DeleteFieldFailure({required this.errMessage, required this.errors});
}
class FarmDetailsSuccess extends FieldState{}
class FarmDetailsFailure extends FieldState {
  final String errMessage;
  final dynamic errors;

  FarmDetailsFailure({required this.errMessage, required this.errors});
}



//=========================================================================
//========================= IrrigationDeviceState =========================
//=========================================================================

class AddIrrigationUnitSuccess extends FieldState{}
class AddIrrigationUnitFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  AddIrrigationUnitFailure({
    required this.errMessage,
    required this.errors,
  });

}

class ViewIrrigationUnitSuccess extends FieldState{
  final List<IrrigationDevice> devices;
  ViewIrrigationUnitSuccess({
    required this.devices});
}
class ViewIrrigationUnitFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  ViewIrrigationUnitFailure({
    required this.errMessage,
    required this.errors,
  });

}
class IrrigationUnitEmpty extends FieldState{}

class ViewFieldIrrigationUnitSuccess extends FieldState{
  final IrrigationDevice device;
  ViewFieldIrrigationUnitSuccess({
    required this.device});
}
class ViewFieldIrrigationUnitFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  ViewFieldIrrigationUnitFailure({
    required this.errMessage,
    required this.errors,
  });

}

class IrrigationUnitEditSuccess extends FieldState{}

class IrrigationUnitEditFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  IrrigationUnitEditFailure({
    required this.errMessage,
    required this.errors,
  });
  

}

class DeleteIrrigationUnitSuccess extends FieldState {}

final class DeleteIrrigationUnitFailure extends FieldState {
  final String errMessage;
  final dynamic errors;

  DeleteIrrigationUnitFailure({required this.errMessage, required this.errors});
}

class IrrigationUnitToggleSuccess extends FieldState {}

final class IrrigationUnitToggleFailure extends FieldState {
  final String errMessage;
  final dynamic errors;

  IrrigationUnitToggleFailure({required this.errMessage, required this.errors});
}

//=====================================================================
//========================= SensorDeviceState =========================
//=====================================================================
class AddSensorUnitSuccess extends FieldState {
  final SensorDevice device;
  AddSensorUnitSuccess({
    required this.device,
  });
}

class AddSensorUnitFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  AddSensorUnitFailure({
    required this.errMessage,
    required this.errors,
  });

}

class ViewSensorUnitsSuccess extends FieldState{
  final List<SensorDevice> devices;
  ViewSensorUnitsSuccess({
    required this.devices});
}
class ViewSensorUnitsFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  ViewSensorUnitsFailure({
    required this.errMessage,
    required this.errors,
  });

}
class SensorUnitsEmpty extends FieldState{}

class ViewFieldSensorUnitSuccess extends FieldState{
  final SensorDevice device;
  ViewFieldSensorUnitSuccess({
    required this.device});
}
class ViewFieldSensorUnitFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  ViewFieldSensorUnitFailure({
    required this.errMessage,
    required this.errors,
  });

}

class SensorUnitEditSuccess extends FieldState{}

class SensorUnitEditFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  SensorUnitEditFailure({
    required this.errMessage,
    required this.errors,
  });
  

}

class DeleteSensorUnitSuccess extends FieldState {}

final class DeleteSensorUnitFailure extends FieldState {
  final String errMessage;
  final dynamic errors;

  DeleteSensorUnitFailure({required this.errMessage, required this.errors});
}

