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

//fields ظهرت
class FieldSuccess extends FieldState{}

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

//=====================================================================
//========================= SensorDeviceState =========================
//=====================================================================
class AddSensorUnitSuccess extends FieldState {
  final SensorDevices devices;
  AddSensorUnitSuccess({
    required this.devices,
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
  final List<SensorDevices> devices;
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

class ISensorUnitEditSuccess extends FieldState{}

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

//=======================================================================
//========================= AutomatedRulesState =========================
//=======================================================================

class AddAutomationRulesSuccess extends FieldState{}
class AddAutomationRulesFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  AddAutomationRulesFailure({
    required this.errMessage,
    required this.errors,
  });

}

class ViewAutomationRulesSuccess extends FieldState {
  final List<IrrigationDevice> rules;
  ViewAutomationRulesSuccess({
    required this.rules,
  });
}
class ViewAutomationRulesFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
  ViewAutomationRulesFailure({
    required this.errMessage,
    required this.errors,
  });

}
class AutomationRulesEmpty extends FieldState{}

class AutomationRulesEditSuccess extends FieldState{}

class AutomationRulesEditFailure extends FieldState {
  final String errMessage;
  final dynamic errors;
 AutomationRulesEditFailure({
    required this.errMessage,
    required this.errors,
  });
  

}

class DeleteAutomationRulesSuccess extends FieldState {}

final class DeleteAutomationRulesFailure extends FieldState {
  final String errMessage;
  final dynamic errors;

  DeleteAutomationRulesFailure({required this.errMessage, required this.errors});
}
