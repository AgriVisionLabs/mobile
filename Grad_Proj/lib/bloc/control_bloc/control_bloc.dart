// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/models/diseaseDetections.dart';
import 'package:grd_proj/models/inv_item_model.dart';
import 'package:grd_proj/service/api/api_consumer.dart';
import 'package:grd_proj/service/api/end_points.dart';
import 'package:grd_proj/service/errors/exception.dart';
import 'package:grd_proj/models/automation_rule_model.dart';
import 'package:grd_proj/models/task_model.dart';
import 'package:http_parser/http_parser.dart';

part 'control_event.dart';
part 'control_state.dart';

class ControlBloc extends Bloc<ControlEvent, ControlState> {
  final ApiConsumer api;
  GlobalKey<FormState> ruleFormKey = GlobalKey();
  TextEditingController ruleName = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController minThresholdValue = TextEditingController();
  TextEditingController maxThresholdValue = TextEditingController();
  TextEditingController targetSensorType = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController activeDays = TextEditingController();
  GlobalKey<FormState> taskFormKey = GlobalKey();
  TextEditingController assignedToId = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController itemPriority = TextEditingController();
  TextEditingController category = TextEditingController();
  GlobalKey<FormState> itemFormKey = GlobalKey();
  TextEditingController fieldId = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController thresholdQuantity = TextEditingController();
  TextEditingController itemCategory = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController unitCost = TextEditingController();
  TextEditingController measurementUnit = TextEditingController();
  TextEditingController expirationDate = TextEditingController();
  GlobalKey<FormState> logFormKey = GlobalKey();
  TextEditingController reason = TextEditingController();
  TextEditingController farmName = TextEditingController();
  TextEditingController fieldName = TextEditingController();
  TextEditingController cropName = TextEditingController();
  TextEditingController farmId = TextEditingController();

  ControlBloc(this.api) : super(ControlInitial()) {
    on<AddAutomationRulesEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.post(
            "${EndPoints.automationRules}/${event.farmId}/fields/${event.fieldId}/AutomationRules",
            data: {
              ApiKey.name: ruleName.text,
              ApiKey.type: int.parse(type.text),
              ApiKey.minThresholdValue:
                  int.tryParse(type.text) == 1 ? null : minThresholdValue.text,
              ApiKey.maxThresholdValue:
                  int.tryParse(type.text) == 1 ? null : maxThresholdValue.text,
              ApiKey.targetSensorType: int.tryParse(type.text) == 1
                  ? null
                  : int.tryParse(targetSensorType.text),
              ApiKey.startTime:
                  int.tryParse(type.text) == 0 ? null : startTime.text,
              ApiKey.endTime:
                  int.tryParse(type.text) == 0 ? null : endTime.text,
              ApiKey.activeDays: int.tryParse(type.text) == 0
                  ? null
                  : int.tryParse(activeDays.text),
            });
        final rules = AutomationRuleModel.fromJson(response);
        emit(AddAutomationRulesSuccess(rules: rules));
      } on ServerException catch (e) {
        emit(AddAutomationRulesFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<OpenFarmAutomationRulesEvent>((event, emit) async {
      try {
        final response = await api.get(
            "${EndPoints.automationRules}/${event.farmId}/AutomationRules");
        if (response is List && response.isNotEmpty) {
          final rules = response
              .map<AutomationRuleModel>(
                  (json) => AutomationRuleModel.fromJson(json))
              .toList();
          emit(ViewAutomationRulesSuccess(
            rules: rules,
          ));
        } else {
          emit(AutomationRulesEmpty());
        }
      } on ServerException catch (e) {
        emit(ViewAutomationRulesFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<OpenFieldAutomationRulesEvent>((event, emit) async {
      try {
        final response = await api.get(
            "${EndPoints.automationRules}/${event.farmId}/fields/${event.fieldId}/AutomationRules/${event.ruleId}");
        final rule = AutomationRuleModel.fromJson(response);
        emit(ViewAutomationRuleSuccess(rule: rule));
      } on ServerException catch (e) {
        emit(ViewAutomationRuleFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<AutomationRulesEditEvent>((event, emit) async {
      try {
        final response = await api.put(
            "${EndPoints.automationRules}/${event.farmId}/fields/${event.fieldId}/AutomationRules/${event.ruleId}",
            data: {
              ApiKey.farmId: event.farmId,
              ApiKey.farmId: event.fieldId,
              ApiKey.automationRuleId: event.ruleId,
              ApiKey.requesterId: CacheHelper.getData(key: "id"),
              ApiKey.name: event.name,
              ApiKey.isEnabled: event.isEnabled,
              ApiKey.type: event.type,
              ApiKey.maxThresholdValue: event.type == 1 ? null : event.min,
              ApiKey.minThresholdValue: event.type == 1 ? null : event.max,
              ApiKey.targetSensorType: event.type == 1 ? null : event.target,
              ApiKey.startTime: event.type == 0 ? null : event.start,
              ApiKey.endTime: event.type == 0 ? null : event.end,
              ApiKey.activeDays: event.type == 0 ? null : event.days,
            });
        emit(AutomationRulesEditSuccess());
      } on ServerException catch (e) {
        emit(AutomationRulesEditFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<DeleteAutomationRulesEvent>((event, emit) async {
      try {
        final response = await api.delete(
            '${EndPoints.automationRules}/${event.farmId}/fields/${event.fieldId}/AutomationRules/${event.ruleId}');
      } on ServerException catch (e) {
        emit(DeleteAutomationRulesFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<AddTaskEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.post(
            "${EndPoints.task}/${event.farmId}/fields/${event.fieldId}/Tasks",
            data: {
              ApiKey.assignedToId:
                  assignedToId.text.isEmpty ? null : assignedToId.text,
              ApiKey.title: title.text,
              ApiKey.description:
                  description.text.isEmpty ? null : description.text,
              ApiKey.dueDate:
                  dueDate.text.isEmpty ? null : dueDate.text.toString(),
              ApiKey.targetSensorType: targetSensorType.text.isEmpty
                  ? null
                  : int.tryParse(targetSensorType.text),
              ApiKey.itemPriority: int.parse(itemPriority.text),
              ApiKey.category: int.parse(category.text),
            });
        final task = TaskModel.fromJson(response);

        emit(AddTaskSuccess(task: task));
      } on ServerException catch (e) {
        emit(AddTaskFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<OpenFarmTasksEvent>((event, emit) async {
      try {
        final response =
            await api.get("${EndPoints.task}/${event.farmId}/Tasks");
        if (response is List && response.isNotEmpty) {
          final tasks = response
              .map<TaskModel>((json) => TaskModel.fromJson(json))
              .toList();
          emit(ViewTasksSuccess(
            tasks: tasks,
          ));
        } else {
          emit(TasksEmpty());
        }
      } on ServerException catch (e) {
        emit(ViewTasksFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<OpenTaskEvent>((event, emit) async {
      try {
        final response = await api
            .get("${EndPoints.task}/${event.farmId}/Tasks/${event.taskId}");
        final task = TaskModel.fromJson(response);
        emit(ViewTaskSuccess(task: task));
      } on ServerException catch (e) {
        emit(ViewTaskFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<DeteteTaskEvent>((event, emit) async {
      try {
        final response = await api
            .delete("${EndPoints.task}/${event.farmId}/Tasks/${event.taskId}");
        emit(DeleteTaskSuccess());
      } on ServerException catch (e) {
        emit(DeleteTaskFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<CompleteTaskEvent>((event, emit) async {
      try {
        final response = await api.post(
            "${EndPoints.task}/${event.farmId}/Tasks/${event.taskId}/complete");
        emit(DeleteTaskSuccess());
      } on ServerException catch (e) {
        emit(DeleteTaskFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<AddItemEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api
            .post("${EndPoints.task}/${event.farmId}/InventoryItems", data: {
          ApiKey.fieldId: fieldId.text.isEmpty ? null : fieldId.text,
          ApiKey.name: itemName.text,
          ApiKey.category: int.tryParse(itemCategory.text),
          ApiKey.quantity: quantity.text,
          ApiKey.thresholdQuantity: thresholdQuantity.text,
          ApiKey.unitCost: unitCost.text,
          ApiKey.measurementUnit: measurementUnit.text,
          ApiKey.expirationDate:
              expirationDate.text.isEmpty ? null : expirationDate.text
        });
        final item = InvItemModel.fromJson(response);

        emit(AddItemSuccess(item: item));
      } on ServerException catch (e) {
        emit(AddItemFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });
    on<OpenFarmItemsEvent>((event, emit) async {
      try {
        final response =
            await api.get("${EndPoints.task}/${event.farmId}/InventoryItems");
        if (response is List && response.isNotEmpty) {
          final items = response
              .map<InvItemModel>((json) => InvItemModel.fromJson(json))
              .toList();
          emit(ViewItemsSuccess(items: items));
        } else {
          emit(ItemEmpty());
        }
      } on ServerException catch (e) {
        emit(ViewItemsFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<OpenItemEvent>((event, emit) async {
      try {
        final response =
            await api.get("${EndPoints.task}/${event.farmId}/InventoryItems");
        final item = InvItemModel.fromJson(response);
        emit(ViewItemSuccess(item: item));
      } on ServerException catch (e) {
        emit(ViewItemFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<DeleteItemEvent>((event, emit) async {
      try {
        final response = await api.delete(
            "${EndPoints.task}/${event.farmId}/InventoryItems/${event.itemId}");
        emit(DeleteTaskSuccess());
      } on ServerException catch (e) {
        emit(DeleteTaskFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<EditItemEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.put(
            "${EndPoints.task}/${event.farmId}/InventoryItems/${event.itemId}",
            data: {
              ApiKey.fieldId: fieldId.text.isEmpty ? null : fieldId.text,
              ApiKey.name: itemName.text,
              ApiKey.category: int.tryParse(itemCategory.text),
              ApiKey.quantity: quantity.text,
              ApiKey.thresholdQuantity: thresholdQuantity.text,
              ApiKey.unitCost: unitCost.text,
              ApiKey.measurementUnit: measurementUnit.text,
              ApiKey.expirationDate:
                  expirationDate.text.isEmpty ? null : expirationDate.text
            });

        emit(ItemEditSuccess());
      } on ServerException catch (e) {
        emit(ItemEditFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<AddLogEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.post(
            "${EndPoints.task}/${event.farmId}/InventoryItems/${event.itemId}/log",
            data: {
              ApiKey.quantity: quantity.text,
              ApiKey.reason: int.tryParse(reason.text),
            });

        emit(ChangeLogSuccess());
      } on ServerException catch (e) {
        emit(ChangeLogFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });
    //=====================================================================
//========================= DiseaseDetection =========================
//=====================================================================

    on<UseDiseaseDetectionEvent>((event, emit) async {
      try {
        final filePath = event.media.path;
        final fileName = filePath.split('/').last;
        final fileExtension = filePath.split('.').last.toLowerCase();

        MediaType mediaType;
        if (['jpg', 'jpeg'].contains(fileExtension)) {
          mediaType = MediaType('image', 'jpeg');
        } else if (fileExtension == 'png') {
          mediaType = MediaType('image', 'png');
        } else if (fileExtension == 'mp4') {
          mediaType = MediaType('video', 'mp4');
        } else {
          emit(DiseaseScanFailure(
            errMessage: 'Unsupported file type: .$fileExtension',
            errors: const {},
          ));
          return;
        }

        final formData = FormData.fromMap({
          'Image': await MultipartFile.fromFile(
            filePath,
            filename: fileName,
            contentType: mediaType,
          ),
        });

        final response = await api.post(
          "${EndPoints.diseaseDetections}/${event.farmId}/fields/${event.fieldId}/DiseaseDetections",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          ),
        );

        final info = DiseaseDetectionModel.fromJson(response);
        emit(DiseaseScanSuccess(info: info));
      } on ServerException catch (e) {
        emit(DeleteAutomationRulesFailure(
          errMessage: e.errorModel.message,
          errors: e.errorModel.error,
        ));
      }
    });

    on<OpenFarmDiseaseDetectionEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.get(
          "${EndPoints.diseaseDetections}/${event.farmId}/DiseaseDetections",
        );

        if (response is List && response.isNotEmpty) {
          final fieldInfo = response
              .map<DiseaseDetectionModel>(
                  (json) => DiseaseDetectionModel.fromJson(json))
              .toList();
          emit(ViewDetectionsSuccess(
            info: fieldInfo,
          ));
        } else {
          emit(DiseaseDetectionEmpty());
        }
      } on ServerException catch (e) {
        emit(ViewDiseaseDetectionsFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<OpenFieldDiseaseDetectionEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.get(
          "${EndPoints.diseaseDetections}/${event.farmId}/fields/${event.fieldId}/DiseaseDetections",
        );

        if (response is List && response.isNotEmpty) {
          final fieldInfo = response
              .map<DiseaseDetectionModel>(
                  (json) => DiseaseDetectionModel.fromJson(json))
              .toList();
          emit(ViewDetectionsSuccess(
            info: fieldInfo,
          ));
        } else {
          emit(DiseaseDetectionEmpty());
        }
      } on ServerException catch (e) {
        emit(ViewDiseaseDetectionsFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<OpenDiseaseDetectionEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.get(
          "${EndPoints.diseaseDetections}/${event.farmId}/DiseaseDetections/${event.scanid}",
        );

        final fieldInfo = DiseaseDetectionModel.fromJson(response);
        emit(DiseaseDetectionSuccess(
          info: fieldInfo,
        ));
      } on ServerException catch (e) {
        emit(DiseaseDetectionFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });
  }
}
