// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/core/api/api_consumer.dart';
import 'package:grd_proj/core/api/end_points.dart';
import 'package:grd_proj/core/errors/exception.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/models/irrigation_model.dart';
import 'package:grd_proj/models/sensor_model.dart';

part 'field_event.dart';
part 'field_state.dart';

//each time you call the bolc it request event and state
class FieldBloc extends Bloc<FieldEvent, FieldState> {
  final ApiConsumer api;
  GlobalKey<FormState> createFieldFormKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController cropType = TextEditingController();
  GlobalKey<FormState> addIrrigationUnitFormKey = GlobalKey();
  TextEditingController irrigationUnitName = TextEditingController();
  TextEditingController irrigationSerialNum = TextEditingController();
  TextEditingController irrigationStatus = TextEditingController();
  TextEditingController irrigationNewFieldId = TextEditingController();
  GlobalKey<FormState> addSensorUnitFormKey = GlobalKey();
  TextEditingController sensorUnitName = TextEditingController();
  TextEditingController sensorSerialNum = TextEditingController();
  TextEditingController sensorStatus = TextEditingController();
  TextEditingController sensorNewFieldId = TextEditingController();
  TextEditingController nextStep1 = TextEditingController();
  TextEditingController nextStep2 = TextEditingController();
  
  FieldModel? fieldmodel;
  
  //default value
  FieldBloc(this.api) : super(FieldInitial(const [])) {
    //get all farms FarmScreen
    on<OpenFieldEvent>((event, emit) async {
      try {
        emit(FieldInitial(const []));
        if (event.farmname != null) {
          CacheHelper.saveData(key: 'farmname', value: event.farmname);
          CacheHelper.saveData(key: 'area', value: event.size);
          CacheHelper.saveData(key: 'soiltype', value: event.soiltype);
          CacheHelper.saveData(key: 'location', value: event.location);
          CacheHelper.saveData(key: 'roleName', value: event.roleName);
        }
        CacheHelper.saveData(key: 'farmId', value: event.farmId);
        emit(FieldLoading());
        final response =
            await api.get('${EndPoints.feild}/${event.farmId}/Fields');
        if (response is List && response.isNotEmpty) {
          final fields = response
              .map<FieldModel>((json) => FieldModel.fromJson(json))
              .toList();
          emit(FieldLoaded(fields: fields));
        } else {
          emit(FieldEmpty());
        }
        print(response);
      } on ServerException catch (e) {
        emit(FieldLoadingFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<CreateFieldEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response =
            await api.post("${EndPoints.feild}/${event.farmId}/Fields", data: {
          ApiKey.name: name.text,
          ApiKey.area: area.text,
          ApiKey.crop: int.tryParse(cropType.text),
        });
        fieldmodel = FieldModel.fromJson(response);
        CacheHelper.saveData(key: 'fieldId', value: fieldmodel!.id);
        print(response);
        emit(FieldInfoSuccess());
      } on ServerException catch (e) {
        emit(FieldInfoFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<DeleteFieldEvent>((event, emit) async {
      try {
        final response = await api.delete(
            '${EndPoints.farmControl}/${event.farmId}/Fields/${event.fieldId}}');
        print(response);
        emit(DeleteFieldSuccess());
      } on ServerException catch (e) {
        emit(DeleteFieldFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });


    on<ViewFieldDetails>((event, emit) async {
      try {
        final response = await api.get(
            "${EndPoints.farmControl}/${event.farmId}/Fields/${event.fieldId}");
        fieldmodel = FieldModel.fromJson(response);
        emit(FieldSuccess(field: fieldmodel!));
      } on ServerException catch (e) {
        emit(FieldFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<AddIrrigationUnitEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.post(
            "${EndPoints.irrigation}/${event.farmId}/fields/${event.fieldId}/IrrigationUnits",
            data: {
              ApiKey.serialNumber: irrigationSerialNum.text,
              ApiKey.name: irrigationUnitName.text,
            });
        print(response);
        emit(AddIrrigationUnitSuccess());
      } on ServerException catch (e) {
        emit(AddIrrigationUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });


    on<OpenFarmIrrigationUnitsEvent>((event, emit) async {
      try {
        final response = await api
            .get("${EndPoints.irrigation}/${event.farmId}/IrrigationUnits");
        print(response);
        if (response is List && response.isNotEmpty) {
          final irrigationUnits = response
              .map<IrrigationDevice>((json) => IrrigationDevice.fromJson(json))
              .toList();
          emit(ViewIrrigationUnitSuccess(
            devices: irrigationUnits,
          ));
        } else {
          emit(IrrigationUnitEmpty());
        }
      } on ServerException catch (e) {
        emit(ViewIrrigationUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<OpenFieldIrrigationUnitsEvent>((event, emit) async {
      try {
        final response = await api.get(
            "${EndPoints.irrigation}/${event.farmId}/fields/${event.fieldId}/IrrigationUnits");
        print(response);
        final irrigationUnit = IrrigationDevice.fromJson(response);
          emit(ViewFieldIrrigationUnitSuccess(
            device: irrigationUnit,
          ));
      } on ServerException catch (e) {
        emit(ViewIrrigationUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<IrrigationUnitsEditEvent>((event, emit) async {
      try {
        // ignore: unused_local_variable
        final response = await api.put(
            "${EndPoints.irrigation}/${event.farmId}/fields/${event.fieldId}/IrrigationUnits",
            data: {
              ApiKey.name: irrigationUnitName.text,
              ApiKey.status: int.tryParse(irrigationStatus.text),
              ApiKey.newFieldId: irrigationNewFieldId.text,
            });
        emit(IrrigationUnitEditSuccess());
      } on ServerException catch (e) {
        emit(IrrigationUnitEditFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<DeleteIrrigationUnitEvent>((event, emit) async {
      try {
        final response = await api.delete('${EndPoints.irrigation}/${event.farmId}/fields/${event.fieldId}/IrrigationUnits');
        print(response);
        emit(DeleteIrrigationUnitSuccess());
      } on ServerException catch (e) {
        emit(DeleteIrrigationUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<IrrigationUnitToggleEvent>((event, emit) async {
      try {
        final response = await api.post('${EndPoints.irrigation}/${event.farmId}/fields/${event.fieldId}/IrrigationUnits/toggle');
        print(response);
        emit(IrrigationUnitToggleSuccess());
      } on ServerException catch (e) {
        emit(IrrigationUnitToggleFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });
//====================================================================================
    on<AddSensorUnitEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.post(
            "${EndPoints.sensor}/${event.farmId}/fields/${event.fieldId}/SensorUnits",
            data: {
              ApiKey.serialNumber: sensorSerialNum.text,
              ApiKey.name: sensorUnitName.text,
            });
            final sensorUnits = SensorDevice.fromJson(response);
        print(response);
        emit(AddSensorUnitSuccess(device: sensorUnits));
      } on ServerException catch (e) {
        emit(AddSensorUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<OpenFarmSensorUnitsEvent>((event, emit) async {
      try {
        final response = await api
            .get("${EndPoints.sensor}/${event.farmId}/SensorUnits");
        print(response);
        if (response is List && response.isNotEmpty) {
          final sensorUnits = response
              .map<SensorDevice>((json) => SensorDevice.fromJson(json))
              .toList();
          emit(ViewSensorUnitsSuccess(
            devices: sensorUnits,
          ));
        } else {
          emit(SensorUnitsEmpty());
        }
      } on ServerException catch (e) {
        emit(ViewIrrigationUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<OpenFieldSensorUnitsEvent>((event, emit) async {
      try {
        final response = await api.get(
            "${EndPoints.sensor}/${event.farmId}/fields/${event.fieldId}/SensorUnits/${event.sensorId}");
        print(response);
        final sensorUnit = SensorDevice.fromJson(response);
          emit(ViewFieldSensorUnitSuccess(
            device: sensorUnit,
          ));
      } on ServerException catch (e) {
        emit(ViewFieldSensorUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<SensorUnitEditEvent>((event, emit) async {
      try {
        // ignore: unused_local_variable
        final response = await api.put(
            "${EndPoints.sensor}/${event.farmId}/fields/${event.fieldId}/SensorUnits/${event.sensorId}",
            data: {
              ApiKey.name: sensorUnitName.text,
              ApiKey.status: int.tryParse(sensorStatus.text),
              ApiKey.newFieldId: sensorNewFieldId.text,
            });
        emit(SensorUnitEditSuccess());
      } on ServerException catch (e) {
        emit(SensorUnitEditFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<DeleteSensorUnitEvent>((event, emit) async {
      try {
        final response = await api.delete('${EndPoints.sensor}/${event.farmId}/fields/${event.fieldId}/SensorUnits/${event.sensorId}');
        print(response);
        emit(DeleteSensorUnitSuccess());
      } on ServerException catch (e) {
        emit(DeleteSensorUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });
    ///=================================================================
    ///
    
  }
}
