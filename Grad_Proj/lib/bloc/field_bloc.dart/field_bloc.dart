// ignore_for_file: avoid_print, unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/models/crop_model.dart';
import 'package:grd_proj/service/api/api_consumer.dart';
import 'package:grd_proj/service/api/end_points.dart';
import 'package:grd_proj/service/errors/exception.dart';
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
  TextEditingController sensorId = TextEditingController();

  // FieldModel? fieldmodel;

  //default value
  FieldBloc(this.api) : super(FieldInitial(const [])) {
    //get all farms FarmScreen
    on<OpenFieldEvent>((event, emit) async {
      try {
        emit(FieldInitial(const []));
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
          ApiKey.cropType: int.tryParse(cropType.text),
        });
        final field = FieldModel.fromJson(response);

        emit(FieldInfoSuccess(field: field));
      } on ServerException catch (e) {
        emit(FieldInfoFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<DeleteFieldEvent>((event, emit) async {
      try {
        final response = await api.delete(
            '${EndPoints.feild}/${event.farmId}/Fields/${event.fieldId}');
        emit(DeleteFieldSuccess());
      } on ServerException catch (e) {
        emit(DeleteFieldFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<EditFieldEvent>((event, emit) async {
      try {
        final response = await api.put(
            "${EndPoints.feild}/${event.farmId}/Fields/${event.fieldId}",
            data: {
              ApiKey.name: name.text,
              ApiKey.area: int.tryParse(area.text),
              ApiKey.cropType: int.tryParse(cropType.text)
            });
        emit(FieldEditSuccess());
      } on ServerException catch (e) {
        emit(FieldEditFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<ViewCropTypes>((event, emit) async {
      try {
        final response = await api.get(EndPoints.cropType);
        final crops = response
            .map<CropModel>((json) => CropModel.fromJson(json))
            .toList();
        emit(ViewCropTypesSuccess(crops: crops));
      } on ServerException catch (e) {
        emit(ViewCropTypesFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<ViewFieldDetails>((event, emit) async {
      try {
        final response = await api.get(
            "${EndPoints.farmControl}/${event.farmId}/Fields/${event.fieldId}");
        final field = FieldModel.fromJson(response);
        emit(FieldSuccess(field: field));
      } on ServerException catch (e) {
        emit(FieldFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

//=========================================================================
//========================= IrrigationDeviceState =========================
//=========================================================================

    on<AddIrrigationUnitEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.post(
            "${EndPoints.irrigation}/${event.farmId}/fields/${event.fieldId}/IrrigationUnits",
            data: {
              ApiKey.serialNumber: irrigationSerialNum.text,
              ApiKey.name: irrigationUnitName.text,
            });
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
        if (response is! String && response.isNotEmpty) {
          final irrigationUnit = IrrigationDevice.fromJson(response);
          emit(ViewFieldIrrigationUnitSuccess(
            device: irrigationUnit,
          ));
        } else {
          emit(IrrigationUnitEmpty());
        }
      } on ServerException catch (e) {
        emit(ViewIrrigationUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<IrrigationUnitsEditEvent>((event, emit) async {
      try {
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
        final response = await api.delete(
            '${EndPoints.irrigation}/${event.farmId}/fields/${event.fieldId}/IrrigationUnits');
        emit(DeleteIrrigationUnitSuccess());
      } on ServerException catch (e) {
        emit(DeleteIrrigationUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<IrrigationUnitToggleEvent>((event, emit) async {
      try {
        final response = await api.post(
            '${EndPoints.irrigation}/${event.farmId}/fields/${event.fieldId}/IrrigationUnits/toggle');
        emit(IrrigationUnitToggleSuccess());
      } on ServerException catch (e) {
        emit(IrrigationUnitToggleFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

//=====================================================================
//========================= SensorDeviceState =========================
//=====================================================================

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
        emit(AddSensorUnitSuccess(device: sensorUnits));
      } on ServerException catch (e) {
        emit(AddSensorUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<OpenFarmSensorUnitsEvent>((event, emit) async {
      try {
        final response =
            await api.get("${EndPoints.sensor}/${event.farmId}/SensorUnits");
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
        if (response is! String && response.isNotEmpty) {
          final sensorUnit = SensorDevice.fromJson(response);
          emit(ViewFieldSensorUnitSuccess(
            device: sensorUnit,
          ));
        } else {
          emit(SensorUnitsEmpty());
        }
      } on ServerException catch (e) {
        emit(ViewFieldSensorUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<SensorUnitEditEvent>((event, emit) async {
      try {
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
        final response = await api.delete(
            '${EndPoints.sensor}/${event.farmId}/fields/${event.fieldId}/SensorUnits/${event.sensorId}');
        emit(DeleteSensorUnitSuccess());
      } on ServerException catch (e) {
        emit(DeleteSensorUnitFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

  }
}
