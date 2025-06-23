import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/core/api/api_consumer.dart';
import 'package:grd_proj/core/api/end_points.dart';
import 'package:grd_proj/core/errors/exception.dart';
import 'package:grd_proj/models/automation_rule_model.dart';
import 'package:meta/meta.dart';

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
  ControlBloc(this.api) : super(ControlInitial()) {
    on<AddAutomationRulesEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.post(
            "${EndPoints.automationRules}/${event.farmId}/fields/${event.fieldId}/AutomationRules",
            data: {
              ApiKey.name: ruleName.text,
              ApiKey.type: int.parse(type.text),
              ApiKey.minThresholdValue: int.tryParse(type.text) ==1 ? null : minThresholdValue.text,
              ApiKey.maxThresholdValue: int.tryParse(type.text) ==1 ? null : maxThresholdValue.text,
              ApiKey.targetSensorType: int.tryParse(type.text) ==1 ? null : int.tryParse(targetSensorType.text),
              ApiKey.startTime: int.tryParse(type.text) ==0 ? null :startTime.text,
              ApiKey.endTime: int.tryParse(type.text) ==0 ? null :endTime.text,
              ApiKey.activeDays: int.tryParse(type.text) ==0 ? null :activeDays.text,
            });
        final rules = AutomationRuleModel.fromJson(response);

        print(response);
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
        print(response);
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
        print(response);
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

    on<AutomationRulesEditEvent>((event, emit) async {
      try {
        // ignore: unused_local_variable
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
              ApiKey.maxThresholdValue: event.type==1? null: event.min,
              ApiKey.minThresholdValue: event.type==1? null: event.max,
              ApiKey.targetSensorType: event.type==1? null: event.target,
              ApiKey.maxThresholdValue: event.type==0? null: event.start,
              ApiKey.maxThresholdValue: event.type==0? null: event.end,
              ApiKey.maxThresholdValue: event.type==0? null: event.days,
            });
      } on ServerException catch (e) {
        emit(AutomationRulesEditFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<DeleteAutomationRulesEvent>((event, emit) async {
      try {
        final response = await api.delete(
            '${EndPoints.automationRules}/${event.farmId}/fields/${event.fieldId}/AutomationRules/${event.ruleId}');
        print(response);
        emit(DeleteAutomationRulesSuccess());
      } on ServerException catch (e) {
        emit(DeleteAutomationRulesFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });
  }
}
